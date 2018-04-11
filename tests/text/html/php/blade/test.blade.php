@include('dummy-view')

@section('first-section')
    <h1>{{ $some_var }}</h1>
    <h1>Test</h1>
@endsection

@section('second-section')

    {{-- ! Comment --}}
    <script src="{{ asset('script.js') }}" charset="utf-8"></script>
@endsection
