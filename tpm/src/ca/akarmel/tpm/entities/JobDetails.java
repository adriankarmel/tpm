package ca.akarmel.tpm.entities;

public class JobDetails {
	
	private int Id;
	private int worker_id;
	private String jobDate;
	private String StartTime;
	private String EndTime;
	
	private String workerName; 	
	
	public JobDetails() {
	}	

	public JobDetails(int id, int worker_id, String jobDate, String startTime, String endTime, String workerName) {
		this.Id = id;
		this.worker_id = worker_id;
		this.jobDate = jobDate;
		this.StartTime = startTime;
		this.EndTime = endTime;
		this.workerName = workerName;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getWorker_id() {
		return worker_id;
	}

	public void setWorker_id(int worker_id) {
		this.worker_id = worker_id;
	}

	public String getJobDate() {
		return jobDate;
	}

	public void setJobDate(String jobDate) {
		this.jobDate = jobDate;
	}

	public String getStartTime() {
		return StartTime;
	}

	public void setStartTime(String startTime) {
		StartTime = startTime;
	}

	public String getEndTime() {
		return EndTime;
	}

	public void setEndTime(String endTime) {
		EndTime = endTime;
	}

	public String getWorkerName() {
		return workerName;
	}

	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}
}