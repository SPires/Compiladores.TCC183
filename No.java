/*
 * 
 */
package codigo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Rodrigo
 */
public class No {   //E as arvores somos nozes
    
    private int ends = 0;
    private String nome;
    private String valor = "";
    private No pai;
    private final List<No> filhos = new ArrayList<>();
    private String expressao = "";
    private String tipo = null;

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getExpressao() {
        return expressao;
    }

    public void setExpressao(String expressao) {
        this.expressao = expressao;
    }

    public int getEnds() {
        return ends;
    }

    public void setEnds(int ends) {
        this.ends = ends;
    }
    
    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public void setPai(No pai) {
        this.pai = pai;
    }
    

    public No(No pai) {
        this.pai = pai;
    }

    public No(No pai, String c) {
        this.pai = pai;
        this.nome = c;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public No getPai() {
        return pai;
    }

    public List<No> getFilhos() {
        return filhos;
    }

    public static No novoFilho(No pai, String conteudo) {
        No no = new No(pai);
        no.setNome(conteudo);
        pai.getFilhos().add(no);
        return no;
    }

    public static No novoFilho(No pai, No filho) {
        filho.setPai(pai);
        pai.getFilhos().add(filho);
        return filho;
    }

    @Override
    public String toString() {
        String resp = this.toString(0);
        return resp;
    }

    public String toString(int profundidade) {
        String resp = "";
        for (int i = 0; i < profundidade; i++) {
            resp += "  ";
        }
        resp += nome + "{\n";
        for (No each : this.getFilhos()) {
            resp += each.toString(profundidade + 1);
        }
        return resp;
    }

}
