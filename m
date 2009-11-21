From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: trouble with the kernel client git repo
Date: Sat, 21 Nov 2009 08:55:51 -0800 (PST)
Message-ID: <1638771833.265881258822551177.JavaMail.root@mail-01.cse.ucsc.edu>
References: <331434.59606.qm@web43133.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <331434.59606.qm@web43133.mail.sp1.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Tim Cullen <timcullen2001@yahoo.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Give one of these a shot:

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
  http://www.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
  http://git.kernel.org/smart/pub/scm/linux/kernel/git/sage/ceph-client.git

Best to use the Git protocol:

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git

You were using the Gitweb URLs, which are the browsable web front-end view
of the ceph-client repository.

-n

----- Original Message -----
From: "Tim Cullen" <timcullen2001@yahoo.com>
To: ceph-devel@lists.sourceforge.net
Sent: Monday, November 16, 2009 3:04:11 PM GMT -08:00 US/Canada Pacific
Subject: [ceph-devel] trouble with the kernel client git repo

I am doing something wrong here or is there something wrong with the kernel client git repo?

[root@rna13 tmp]# git clone http://git.kernel.org/?p=linux/kernel/git/sage/ceph-client.git
Initialized empty Git repository in /root/src/tmp/ceph-client/.git/
fatal: http://git.kernel.org/?p=linux/kernel/git/sage/ceph-client.git/info/refs not found: did you run git update-server-info on the server?



      

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
