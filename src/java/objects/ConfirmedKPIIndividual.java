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
public class ConfirmedKPIIndividual {

    private String codeConfirmedKPI;
    private int confirmedHoD;
    private int confirmedPlanning;
    private int confirmedDGD;
    private int confirmedGD;

    public ConfirmedKPIIndividual() {

    }

    public ConfirmedKPIIndividual(String codeConfirmedKPI, int confirmedHoD, int confirmedPlanning, int confirmedDGD, int confirmedGD) {
        this.codeConfirmedKPI = codeConfirmedKPI;
        this.confirmedHoD = confirmedHoD;
        this.confirmedPlanning = confirmedPlanning;
        this.confirmedDGD = confirmedDGD;
        this.confirmedGD = confirmedGD;
    }

    public void setCodeConfirmedKPI(String codeConfirmedKPI) {
        this.codeConfirmedKPI = codeConfirmedKPI;
    }

    public void setConfirmedHoD(int confirmedHoD) {
        this.confirmedHoD = confirmedHoD;
    }

    public void setConfirmedPlanning(int confirmedPlanning) {
        this.confirmedPlanning = confirmedPlanning;
    }

    public void setConfirmedDGD(int confirmedDGD) {
        this.confirmedDGD = confirmedDGD;
    }

    public void setConfirmedGD(int confirmedGD) {
        this.confirmedGD = confirmedGD;
    }

    public String getCodeConfirmedKPI() {
        return codeConfirmedKPI;
    }

    public int getConfirmedHoD() {
        return confirmedHoD;
    }

    public int getConfirmedPlanning() {
        return confirmedPlanning;
    }

    public int getConfirmedDGD() {
        return confirmedDGD;
    }

    public int getConfirmedGD() {
        return confirmedGD;
    }

}
