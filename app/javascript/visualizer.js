// // DOMContentLoaded イベントが発生したときに実行される処理
// document.addEventListener('DOMContentLoaded', () => {
//     // オーディオプレイヤーとキャンバス要素を取得
//     const audioElement = document.getElementById('audio-player');
//     const canvas = document.getElementById('visualizer');
//     const ctx = canvas.getContext('2d'); // キャンバスの描画コンテキストを取得
//     const width = canvas.width; // キャンバスの幅
//     const height = canvas.height; // キャンバスの高さ

//     let audioContext; // AudioContext オブジェクトを保持する変数
//     let analyser; // AnalyserNode オブジェクトを保持する変数
//     let source; // MediaElementSourceNode オブジェクトを保持する変数

//     // オーディオプレイヤーが再生を開始したときの処理
//     audioElement.addEventListener('play', () => {
//         // AudioContext がまだ作成されていない場合にのみ新しく作成
//         if (!audioContext) {
//             // AudioContext を作成（古いブラウザのために webkitAudioContext をフォールバック）
//             audioContext = new (window.AudioContext || window.webkitAudioContext)();
//             // AnalyserNode を作成
//             analyser = audioContext.createAnalyser();
//             // MediaElementSourceNode を作成し、オーディオ要素をソースとして設定
//             source = audioContext.createMediaElementSource(audioElement);
//             // ソースとアナライザを接続
//             source.connect(analyser);
//             // AnalyserNode と AudioContext の出力を接続
//             analyser.connect(audioContext.destination);
//             // FFT サイズを設定
//             analyser.fftSize = 256;
//         }

//         // AudioContext を再開し、視覚化描画を開始
//         audioContext.resume().then(() => {
//             drawVisualizer();
//         });
//     });

//     const bufferLength = 256; // 周波数データの配列の長さ
//     const dataArray = new Uint8Array(bufferLength); // 音声データの配列

//     // ビジュアライザーを描画する関数
//     function drawVisualizer() {
//         // 毎フレーム描画をリクエスト
//         requestAnimationFrame(drawVisualizer);
//         // 周波数データを取得
//         analyser.getByteFrequencyData(dataArray);
//         // バーを描画する前に、描画する範囲だけをクリア
//         ctx.clearRect(0, 0, width, height); // 画面全体をクリア
//         // 透明な背景を設定
//         ctx.fillStyle = 'rgba(255, 255, 255, 0)'; // 完全に透明な色
//         ctx.fillRect(0, 0, width, height); // 透明な背景を描画

//         const barWidth = (width / bufferLength) * 2.5; // バーの幅を計算
//         let x = 0; // バーの描画位置を初期化
//         // 周波数データを使ってバーを描画
//         for (let i = 0; i < bufferLength; i++) {
//             const barHeight = dataArray[i] / 2; // バーの高さをデータに基づいて計算
//             ctx.fillStyle = 'rgb(250, 250, 250)'; // バーの色を設定
//             // バーを描画
//             ctx.fillRect(x, height - barHeight, barWidth, barHeight);
//             x += barWidth + 1; // 次のバーの位置を計算
//         }
//     }
// });
