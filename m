From: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Subject: Re: Mimic cluster is offline and not healing
Date: Fri, 28 Sep 2018 09:09:23 +0200
Message-ID: <20180928070923.GC17567@shell.dmz.bit.nl>
References: <CAE-AtHqSpX09gnAfgXt1=nmyLKuvjgMMn+qKaiZ0nOUKwEARrA@mail.gmail.com>
 <20180927131043.GB17567@shell.dmz.bit.nl>
 <CAE-AtHodr9iaGF3vhkrv+J8mHsYk384Ni8MpbMvW6Xg_Tdw4GQ@mail.gmail.com>
 <CAE-AtHpGLZu5ygyw0sLkOcB3mt-0pLfcLZiPKYuptDLAafy7uw@mail.gmail.com>
 <CAE-AtHo2UVSFcMHMXszSPJXs=BRKb0PELzryMyu4LVEv910pQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE-AtHo2UVSFcMHMXszSPJXs=BRKb0PELzryMyu4LVEv910pQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: by morphin <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Quoting by morphin (morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org):
> Good news... :)
> 
> After I tried everything. I decide to re-create my MONs from OSD's and
> I used the script:
> https://paste.ubuntu.com/p/rNMPdMPhT5/
> 
> And it worked!!!

Congrats!

> I think when 2 server crashed and come back same time some how MON's
> confused and the maps just corrupted.
> After re-creation all the MONs was have the same map so it worked.
> But still I dont know how to hell the mons can cause endless %95 I/O ???
> This a bug anyway and if you dont want to leave the problem then do
> not "enable" your mons. Just start them manual! Another tough lesson.

The only time we needed to manually start the mons was at "bootstrap"
time. After a reboot they are brought up by systemd ... and it keeps on
working. Have you rebooted your mon(s) after the manual start?

> 
> ceph -s: https://paste.ubuntu.com/p/m3hFF22jM9/
> 
> As you can see below some of the OSDs are still down. And when I start
> them they dont start.
> Check start log: https://paste.ubuntu.com/p/ZJQG4khdbx/
> Debug log: https://paste.ubuntu.com/p/J3JyGShHym/
> 
> What we can do for the problem?
Apply PR https://github.com/ceph/ceph/pull/24064

I see that you are running Mimic 13.2.1 ... 13.2.2 was released a few
days ago. Not sure if this fix has made it into 13.2.2.

> What is the cause of the problem?

Somehow it looks like you hit this issue:
https://tracker.ceph.com/issues/24866

Gr. Stefan

-- 
| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info-68+x73Hep80@public.gmane.org
