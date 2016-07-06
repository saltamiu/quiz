package model;

public class UserHistoryItem {
	private Quiz quiz;
	private int score;
	
	public Quiz getQuiz() {
		return quiz;
	}
	
	public void setQuiz(Quiz quiz) {
		this.quiz = quiz;
	}
	
	public int getScore() {
		return score;
	}
	
	public void setScore(int score) {
		this.score = score;
	}
}
