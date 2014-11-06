From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: PG inconsistency
Date: Thu, 6 Nov 2014 13:48:16 +0000
Message-ID: <BLU175-W5B00922C0B0812C2B503EDF840@phx.gbl>
References: <BLU175-W41E1F32E90ED411A4477FFDF840@phx.gbl>,
	<CAF-rypxJ4JCFSxqGYQ3vqPYUhf8rZqgX6mgMUy-sAGp=96-N_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-rypxJ4JCFSxqGYQ3vqPYUhf8rZqgX6mgMUy-sAGp=96-N_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

We are using v0.80.4. Just would like to ask for general suggestion here :)

Thanks,
Guang

________________________________
> From: malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> Date: Thu, 6 Nov 2014 13:46:12 +0000 
> Subject: Re: [ceph-users] PG inconsistency 
> To: yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org 
> 
> What is your version of the ceph? 
> 0.80.0 - 0.80.3 
> https://github.com/ceph/ceph/commit/7557a8139425d1705b481d7f010683169fd5e49b 
> 
> Thu Nov 06 2014 at 16:24:21, GuangYang 
> <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org<mailto:yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>>: 
> Hello Cephers, 
> Recently we observed a couple of inconsistencies in our Ceph cluster, 
> there were two major patterns leading to inconsistency as I observed: 
> 1) EIO to read the file, 2) the digest is inconsistent (for EC) even 
> there is no read error). 
> 
> While ceph has built-in tool sets to repair the inconsistencies, I also 
> would like to check with the community in terms of what is the best 
> ways to handle such issues (e.g. should we run fsck / xfs_repair when 
> such issue happens). 
> 
> In more details, I have the following questions: 
> 1. When there is inconsistency detected, what is the chance there is 
> some hardware issues which need to be repaired physically, or should I 
> run some disk/filesystem tools to further check? 
> 2. Should we use fsck / xfs_repair to fix the inconsistencies, or 
> should we solely relay on Ceph's repair tool sets? 
> 
> It would be great to hear you experience and suggestions. 
> 
> BTW, we are using XFS in the cluster. 
> 
> Thanks, 
> Guang 
> _______________________________________________ 
> ceph-users mailing list 
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> 
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com 
 		 	   		  
