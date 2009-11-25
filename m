From: Sage Weil <sage@newdream.net>
Subject: Re: Bug list
Date: Tue, 24 Nov 2009 19:13:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0911241907390.8216@cobra.newdream.net>
References: <734c7f730911241051p1053ae28n4e08b91d6e35f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <734c7f730911241051p1053ae28n4e08b91d6e35f2@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Albert Ales <albert.c.ales@gmail.com>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

> Here is some of the issue I experienced:
> 1. I tried to re-export a mounted drive first as a CIFS share with samba:
> worked well. Next I mounted the share on a different system and tried to
> start FTP deamon and the mds crashed : http://pastebin.com/m6a2c68c9.

There is something going wrong much earlier than this in the MDS session 
table.  Can you post/email the full log?  I fixed a few bugs in this area 
on monday, but didn't finish before leaving town for the week.

> 2. I tried to insert a node into the cluster following the wiki procedure
> and the mon process died. I tried mon debug to 20 but nothing meaningful
> came out of it.

We'll do some testing of this and see if we can replicate the problem.

> 3. for the snapshots: is seems that for some reasons I have to create the
> folder .snap first since it does not appear on a ls -la but when I do so I
> get a "directory already exist"

This doesn't sound like a bug.  The .snap directory is hidden by design, 
so you won't e.g. traverse into it when you do a 'du' or 'find'.  Even 
though you won't see it in a directory listing, you it's still there, and 
you can cd into it or mkdir .snap/whatever to create your snapshot.

Although probably, if you mkdir .snap, it should succeed, and thereafter 
'hide' the virtual .snap directory, so that we minimize the extent to 
which we break otherwise valid filenames.  IIRC that's what the netapps 
do with .snapshot.

sage

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
