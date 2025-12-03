import 'package:flutter/material.dart';

void main() {
  runApp(const EntrepreneurQuizApp());
}

class EntrepreneurQuizApp extends StatelessWidget {
  const EntrepreneurQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبار ميولك المقاولاتي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        fontFamily: 'Arial', // Ensure you have a font that supports Arabic
        useMaterial3: true,
      ),
      home: const QuizScreen(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}

class Question {
  final int id;
  final String textA;
  final String textB;
  final int scoreA;
  final int scoreB;

  Question({
    required this.id,
    required this.textA,
    required this.textB,
    required this.scoreA,
    required this.scoreB,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _totalScore = 0;
  bool _isFinished = false;

  final List<Question> _questions = [
    Question(id: 1, textA: "متى بدأت بأي عمل يجب علي الانتهاء منه.", textB: "أنا أفكر باستمرار بأفكار جديدة.", scoreA: 1, scoreB: 2),
    Question(id: 2, textA: "أشعر بالسعادة عندما تزيد مسؤولياتي.", textB: "لا أحب المخاطرة.", scoreA: 2, scoreB: 0),
    Question(id: 3, textA: "لن أفعل أي شيء قد يعرّضني للخسارة.", textB: "إن فهم كيفية كسب المال هو الخطوة الأولى.", scoreA: 0, scoreB: 1),
    Question(id: 4, textA: "لن أخوض أي عمل، إذا كان فشله سيعرّضني للسخرية.", textB: "بالإضافة إلى عملي، سأخذ بعين الاعتبار احتياجات الآخرين.", scoreA: 0, scoreB: 1),
    Question(id: 5, textA: "سأعمل جاهداً للتقدّم في أي عمل أبدأ به.", textB: "سأقوم بتنفيذ الإجراءات التي تجعلني سعيداً وآمناً.", scoreA: 2, scoreB: 0),
    Question(id: 6, textA: "سيسخر الناس مني إذا فشلت.", textB: "أنا أثق بنفسي لكنني أطلب مشورة الآخرين.", scoreA: 0, scoreB: 2),
    Question(id: 7, textA: "سأجد حل للصعوبات عندما أواجهها.", textB: "أسمح لصديقي بتحديد أنشطتي الاجتماعية.", scoreA: 2, scoreB: 0),
    Question(id: 8, textA: "أشعر بارتياح حالياً.", textB: "يمكنني تحقيق نتائج أفضل بكثير مما أحققه في الوقت الحاضر.", scoreA: 1, scoreB: 2),
    Question(id: 9, textA: "أتأكد دائماً من عدم توتر العلاقات الشخصية.", textB: "مهما حدث، سيكون لدي فرصة للتعلم من التجربة.", scoreA: 1, scoreB: 2),
    Question(id: 10, textA: "حتى لو فشلت في جهودي سأتعلم شيئاً.", textB: "أود أن أعيش حياة مريحة وجيدة.", scoreA: 2, scoreB: 1),
    Question(id: 11, textA: "سأستمر فقط في الأنشطة التي تعتمد على الحظ.", textB: "اذا فشلت في عمل ما، سأبحث عن اسباب الفشل.", scoreA: 0, scoreB: 2),
    Question(id: 12, textA: "لا أعتبر موظفيي أصدقائي وسأعاملهم كأصدقاء.", textB: "إذا حصلت على عمل أفضل، سأترك عملي الحالي.", scoreA: 0, scoreB: 1),
    Question(id: 13, textA: "سأفكر كثيراً قبل أن أبدأ فكرة جديدة.", textB: "لا أمانع إذا كان عملي يعاني من أجل تحسن حالة الآخرين.", scoreA: 2, scoreB: 0),
    Question(id: 14, textA: "سأبدأ مشروع جديد بمجرد امتلاكي لرأس المال.", textB: "أتخذ قراراتي المهمة بمفردي.", scoreA: 1, scoreB: 2),
    Question(id: 15, textA: "أحتاج في كثير من الأحيان إلى تحفيز وتشجيع الآخرين.", textB: "إذا لم تتحقق الأشياء وفقاً لرغبتي، فسأجد بديلاً آخر.", scoreA: 1, scoreB: 2),
    Question(id: 16, textA: "من الممكن أن أقع في الخطأ.", textB: "أحب التحدث مع الأصدقاء كثيراً.", scoreA: 2, scoreB: 1),
    Question(id: 17, textA: "أتمنى أن يتم حفظ أموالي بأمان في البنك.", textB: "أحب إثبات أنه يمكنني القيام بشيء ما.", scoreA: 0, scoreB: 2),
    Question(id: 18, textA: "أتمنى لو كان لدي الكثير من المال.", textB: "أتبع نصيحة الآخرين عند اتخاذ القرارات.", scoreA: 0, scoreB: 1),
    Question(id: 19, textA: "على الفرد أولاً أن يساعد أقاربه.", textB: "أنا أستمتع بحل الصعوبات.", scoreA: 0, scoreB: 2),
    Question(id: 20, textA: "حتى لو كنت أعاني، لن أجعل الآخرين يشعرون بالسوء.", textB: "أشعر بالملل بسهولة.", scoreA: 0, scoreB: 1),
    Question(id: 21, textA: "أتمنى أن يزدهر عملي بسرعة.", textB: "سأكون حريصاً على عدم إلقاء اللوم على نفسي.", scoreA: 2, scoreB: 0),
    Question(id: 22, textA: "يجب أن أعمل بشكل مستقل.", textB: "سعادتي تكمن فقط في جمع المال.", scoreA: 1, scoreB: 2),
    Question(id: 23, textA: "إذا فشلت، فسيكون ذلك بسبب الآخرين.", textB: "سأفعل فقط الأشياء الجيدة.", scoreA: 0, scoreB: 1),
    Question(id: 24, textA: "سأكون حريصاً على ألا يضر بسمعتي.", textB: "أستمتع بالعمل لساعات طويلة.", scoreA: 2, scoreB: 1),
    Question(id: 25, textA: "أتمنى أن يكون لدي منزل مريح.", textB: "سأتعلم من الفشل.", scoreA: 1, scoreB: 2),
    Question(id: 26, textA: "أفكر في الآثار على المدى الطويل.", textB: "سيتبع أصدقائي أفكاري.", scoreA: 1, scoreB: 0),
    Question(id: 27, textA: "هدفي هو جمع المال.", textB: "أحب العمل حيث يجتمع أصدقائي.", scoreA: 0, scoreB: 2),
    Question(id: 28, textA: "أعرف ما أقوم به ولا أخشى النقد.", textB: "إذا فشلت، سيزعجني الأمر جداً.", scoreA: 2, scoreB: 0),
    Question(id: 29, textA: "أجد صعوبة في الاعتراف بالهزيمة.", textB: "قبل البدء، سأعمل بنصيحة الاصدقاء.", scoreA: 0, scoreB: 1),
    Question(id: 30, textA: "كل تجاربي ستحفزني.", textB: "أتمنى أن يكون لدي الكثير من المال.", scoreA: 2, scoreB: 0),
    Question(id: 31, textA: "أحب أن أمضي أيامي بهدوء.", textB: "إذا فشلت، سأحاول معرفة السبب.", scoreA: 0, scoreB: 2),
    Question(id: 32, textA: "لا أحب تدخل الآخرين.", textB: "سأفعل أي شيء لكسب المال.", scoreA: 1, scoreB: 2),
  ];

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        _isFinished = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _totalScore = 0;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختبار ميولك المقاولاتي"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isFinished
              ? _buildResultScreen()
              : _buildQuestionScreen(),
        ),
      ),
    );
  }

  Widget _buildQuestionScreen() {
    final question = _questions[_currentIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
          value: (_currentIndex + 1) / _questions.length,
          backgroundColor: Colors.teal.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
        const SizedBox(height: 20),
        Text(
          "السؤال ${_currentIndex + 1} من ${_questions.length}",
          style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOptionCard(
                  text: question.textA,
                  onTap: () => _answerQuestion(question.scoreA),
                  label: "أ",
                ),
                const SizedBox(height: 20),
                _buildOptionCard(
                  text: question.textB,
                  onTap: () => _answerQuestion(question.scoreB),
                  label: "ب",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard({required String text, required VoidCallback onTap, required String label}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal.withOpacity(0.1),
                child: Text(label, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 18, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    String feedback;
    if (_totalScore > 45) {
      feedback = "لديك ميول مقاولاتية عالية جداً! أنت مستعد للبدء في مشروعك الخاص.";
    } else if (_totalScore > 30) {
      feedback = "لديك ميول مقاولاتية متوسطة. يمكنك تعزيز مهاراتك بشكل أكبر.";
    } else {
      feedback = "ميولك المقاولاتية منخفضة حالياً، لكن يمكنك تطويرها بالتعلم والممارسة.";
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events_rounded, size: 80, color: Colors.teal),
          const SizedBox(height: 20),
          const Text(
            "النتيجة النهائية",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "$_totalScore / 64",
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 20),
          Text(
            feedback,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _restartQuiz,
            icon: const Icon(Icons.refresh),
            label: const Text("إعادة الاختبار"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}