From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Increase PG or reweight OSDs?
Date: Wed, 3 May 2017 16:27:30 +0530
Message-ID: <CANA9Uk6ba=RYj0g4_81wfGsRm-ejs+tr4tYiD2DUEihMqx9gTw@mail.gmail.com>
References: <CANA9Uk5GQRbKgy+BuV++piJpw17ts6iDAuVz7LpT2+=7wrANMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5GQRbKgy+BuV++piJpw17ts6iDAuVz7LpT2+=7wrANMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

+ Ceph-devel

On Tue, May 2, 2017 at 11:46 AM, M Ranga Swami Reddy
<swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello,
> I have added 5 new Ceph OSD nodes to my ceph cluster. Here, I wanted
> to increase PG/PGP numbers of pools based new OSDs count. Same time
> need to increase the newly added OSDs weight from 0 -> 1.
>
> My question is:
> Do I need to increase the PG/PGP num increase and then reweight the OSDs?
> Or
> Reweight the OSDs first and then increase the PG/PGP num. of pool(s)?
>
> Both will cause the rebalnce...but wanted to understand, which one
> should be preferable to do on running cluster.
>
> Thanks
> Swami
