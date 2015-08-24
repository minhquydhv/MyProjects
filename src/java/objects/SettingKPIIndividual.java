/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package objects;

/**
 *
 * @author Admin
 */
public class SettingKPIIndividual {

    private String codeKPIIndividual;
    private String jobField;
    private String currentStatus;
    private String kpiTarget;
    private String ratio;
    private String remark;

    //day la ham khoi tao khong tham so
    public SettingKPIIndividual() {
    }

    //day la ham khoi tao co tham so
    public SettingKPIIndividual(String codeKPIIndividual, String jobField, String currentStatus, String kpiTarget, String ratio, String remark) {
        this.codeKPIIndividual = codeKPIIndividual;
        this.jobField = jobField;
        this.currentStatus = currentStatus;
        this.kpiTarget = kpiTarget;
        this.ratio = ratio;
        this.remark = remark;
    }
    //cac ham set

    public void setCodeKPIIndividual(String codeKPIIndividual) {
        this.codeKPIIndividual = codeKPIIndividual;
    }

    public void setJobField(String jobField) {
        this.jobField = jobField;
    }

    public void setCurrentStatus(String currentStatus) {
        this.currentStatus = currentStatus;
    }

    public void setKpiTarget(String kpiTarget) {
        this.kpiTarget = kpiTarget;
    }

    public void setRatio(String ratio) {
        this.ratio = ratio;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    //cac ham get
    public String getCodeKPIIndividual() {
        return codeKPIIndividual;
    }

    public String getJobField() {
        return jobField;
    }

    public String getCurrentStatus() {
        return currentStatus;
    }

    public String getKpiTarget() {
        return kpiTarget;
    }

    public String getRatio() {
        return ratio;
    }

    public String getRemark() {
        return remark;
    }

}
