From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: ubuntu problem while trying to get Ceph working with 2 servers
Date: Sun, 4 Jul 2010 19:09:17 +0200
Message-ID: <201007041909.17310.cray@unix-ag.uni-kl.de>
References: <201007032221.24831.cray@unix-ag.uni-kl.de> <i0q3tn$q8m$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:39369 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0GDRJ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jul 2010 13:09:27 -0400
In-Reply-To: <i0q3tn$q8m$1@dough.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

You had the right idea. 

/var/log/auth.log told me what the problem was:

Jul  4 16:31:38 ip-10-212-118-67 sshd[18792]: Authentication refused: bad ownership or modes for file /root/.ssh/authorized_keys

This was not working:

# ls -l /root/.ssh/authorized_keys
-rw------- 1 ubuntu ubuntu 612 2010-07-04 16:30 /root/.ssh/authorized_keys

After this command it works now:

# chown root:root /root/.ssh/authorized_keys

Thanks a lot for your help! :-)

Best Regards,
   Christian 


Am Sonntag, 4. Juli 2010 schrieb Thomas Mueller:
> 
> > But Ubuntu does not allow to login as root.
> > 
> > # ssh root@ec2-67-202-18-178.compute-1.amazonaws.com Permission denied
> > (publickey).
> 
> did you check the /var/log/auth.log and /var/log/syslog on the slave for 
> sshd error messages?
> 
> if you created the /root/.ssh directory yourself on the slave it has 
> maybe wrong permissions.
> 
> or maybe ubuntu has disabled root login in /etc/ssh/sshd_config ? but 
> last time i used it it was not disabled.
> 
> - Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


