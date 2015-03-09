package be.test.mavenwebapplication.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dimitridw
 */
@Entity
@Table(name = "MESSAGES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MessageEntity.findAll", query = "SELECT m FROM MessageEntity m"),
    @NamedQuery(name = "MessageEntity.findById", query = "SELECT m FROM MessageEntity m WHERE m.id = :id"),
    @NamedQuery(name = "MessageEntity.findByMessage", query = "SELECT m FROM MessageEntity m WHERE m.message = :message")})
public class MessageEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private Long id;
    @Size(max = 1024)
    @Column(name = "MESSAGE")
    private String message;
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    @ManyToOne
    private UserEntity userId;

    public MessageEntity() {
    }

    public MessageEntity(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public UserEntity getUserId() {
        return userId;
    }

    public void setUserId(UserEntity userId) {
        this.userId = userId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MessageEntity)) {
            return false;
        }
        MessageEntity other = (MessageEntity) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "be.mips.cyberlab.guestbook.entity.MessageEntity[ id=" + id + " ]";
    }
    
}
