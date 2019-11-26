From: Fyodor Ustinov <ufm-TAHq1US7lqU@public.gmane.org>
Subject: Re: scrub errors on rgw data pool
Date: Tue, 26 Nov 2019 04:32:45 +0200 (EET)
Message-ID: <1067131621.54855.1574735565028.JavaMail.zimbra@ufm.su>
References: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi!

I had similar errors in pools on SSD until I upgraded to nautilus (clean bluestore installation)

----- Original Message -----
> From: "M Ranga Swami Reddy" <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Monday, 25 November, 2019 12:04:46
> Subject: [ceph-users] scrub errors on rgw data pool

> Hello - We are using the ceph 12.2.11 version (upgraded from Jewel 10.2.12 to
> 12.2.11). In this cluster, we are having mix of filestore and bluestore OSD
> backends.
> Recently we are seeing the scrub errors on rgw buckets.data pool every day,
> after scrub operation performed by Ceph. If we run the PG repair, the errors
> will go way.
> 
> Anyone seen the above issue?
> Is the mix of filestore backend has bug/issue with 12.2.11 version (ie
> Luminous).
> Is the mix of filestore and bluestore OSDs cause this type of issue?
> 
> Thanks
> Swami
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
