using System;
using System.Collections.ObjectModel;
using IllnessTracker.Models;
using IllnessTracker.Services;

namespace IllnessTracker.ViewModels;

public class MainWindowViewModel : ViewModelBase
{
    private readonly DatabaseService _db = new();
    private int _page = 1;
    private int _totalPages = 1;
    private string _status = "";
    private IllnessRecordView? _selected;

    public ObservableCollection<IllnessRecordView> Records { get; } = new();
    public IllnessRecordView? SelectedRecord { get => _selected; set { _selected = value; OnPropertyChanged(); } }
    public string Status { get => _status; set { _status = value; OnPropertyChanged(); } }
    public string PageInfo => $"СТРАНИЦА {_page} ИЗ {_totalPages}";

    public MainWindowViewModel() => Refresh();

    public void Refresh()
    {
        try {
            int total = _db.GetTotal();
            _totalPages = (int)Math.Ceiling((double)total / 10);
            if (_totalPages == 0) _totalPages = 1;

            var data = _db.GetPage(_page, 10);
            Records.Clear();
            foreach (var item in data) Records.Add(item);
            
            Status = _db.GetStats();
            OnPropertyChanged(nameof(PageInfo));
        } catch (Exception ex) { Status = "ОШИБКА: " + ex.Message; }
    }

    public void Next() { if (_page < _totalPages) { _page++; Refresh(); } }
    public void Prev() { if (_page > 1) { _page--; Refresh(); } }
    
    public void DeleteSelected()
    {
        if (SelectedRecord == null) return;
        _db.Delete(SelectedRecord.Id);
        Refresh();
    }
}