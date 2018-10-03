From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Mimic offline problem
Date: Wed, 3 Oct 2018 03:14:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1810030311230.31802@piezo.novalocal>
References: <4C31C6EC-573D-42AD-BC6C-F7F103DBEC16@gmail.com>
 <CAE-AtHrjekCcLmO7MUB86XG7VH+bBt6yJH+ZRe7Wnh3tKB8JWw@mail.gmail.com>
 <CANrNMwUaER4e97schGN+KnB_6aNF6SYpPEFvLD=qcpp1eeWEJg@mail.gmail.com>
 <44698713-3F6C-451D-B67B-2053D1B30557@gmail.com>
 <CANrNMwW-RiVxtUnjTrZpiRXi6k06LxaeqRCqbXiuwwjTStWBhA@mail.gmail.com>
 <F96A1781-7767-40A4-B814-C59C0CDD5E68@gmail.com>
 <E516BA34-165C-4542-B53D-B022B913874A@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-920813624-1538536483=:31802"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <E516BA34-165C-4542-B53D-B022B913874A-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?Q?G=C3=B6ktu=C4=9F_Y=C4=B1ld=C4=B1r=C4=B1m?= <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-920813624-1538536483=:31802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

osd_find_best_info_ignore_history_les is a dangerous option and you should 
only use it in very specific circumstances when directed by a developer.  
In such cases it will allow a stuck PG to peer.  But you're not getting to 
that point...you're seeing some sort of resource exhaustion.

The noup trick works when OSDs are way behind on maps and all need to 
catch up.  The way to tell if they are behind is by looking at the 'ceph 
daemon osd.NNN status' output and comparing to the latest OSDMap epoch tha 
t the mons have.  Were they really caught up when you unset noup?

I'm just catching up and haven't read the whole thread but I haven't seen 
anything that explains why teh OSDs are dong lots of disk IO.  Catching up 
on maps could explain it but not why they wouldn't peer once they were all 
marked up...

sage


On Tue, 2 Oct 2018, Göktuğ Yıldırım wrote:

> Anyone heart about osd_find_best_info_ignore_history_les = true ?
> Is that be usefull here? There is such a less information about it.
> 
> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> şunları yazdı (2 Eki 2018 22:11):
> 
> > Hi,
> > 
> > Indeed I left ceph-disk to decide the wal and db partitions when I read somewhere that that will do the proper sizing. 
> > For the blustore cache size I have plenty of RAM. I will increase 8GB for each and decide a more calculated number    after cluster settles.
> > 
> > For the osd map loading I’ve also figured it out. And it is in loop. For that reason I started cluster with noup flag and waited OSDs to reach the uptodate epoch number. After that I unset noup. But I did not pay attention to manager logs. Let me check it, thank you!
> > 
> > I am not forcing jmellac or anything else really. I have a very standard installation and no tweaks or tunings. All we ask for the stability versus speed from the begining. And here we are :/
> > 
> >> On 2 Oct 2018, at 21:53, Darius Kasparavičius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> 
> >> Hi,
> >> 
> >> 
> >> I can see some issues from the osd log file. You have an extremely low
> >> size db and wal partitions. Only 1GB for DB and 576MB for wal. I would
> >> recommend cranking up rocksdb cache size as much as possible. If you
> >> have RAM you can also increase bluestores cache size for hdd. Default
> >> is 1GB be as liberal as you can without getting OOM kills. You also
> >> have lots of osd map loading and decoding in the log. Are you sure all
> >> monitors/managers/osds are up to date? Plus make sure you aren't
> >> forcing jemalloc loading. I had a funny interaction after upgrading to
> >> mimic.
> >> On Tue, Oct 2, 2018 at 9:02 PM Goktug Yildirim
> >> <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> 
> >>> Hello Darius,
> >>> 
> >>> Thanks for reply!
> >>> 
> >>> The main problem is we can not query PGs. “ceph pg 67.54f query” does stucks and wait forever since OSD is unresponsive.
> >>> We are certain that OSD gets unresponsive as soon as it UP. And we are certain that OSD responds again after its disk utilization stops.
> >>> 
> >>> So we have a small test like that:
> >>> * Stop all OSDs (168 of them)
> >>> * Start OSD1. %95 osd disk utilization immediately starts. It takes 8 mins to finish. Only after that “ceph pg 67.54f query” works!
> >>> * While OSD1 is “up" start OSD2. As soon as OSD2 starts OSD1 & OSD2 starts %95 disk utilization. This takes 17 minutes to finish.
> >>> * Now start OSD3 and it is the same. All OSDs start high I/O and it takes 25 mins to settle.
> >>> * If you happen to start 5 of them at the same all of the OSDs start high I/O again. And it takes 1 hour to finish.
> >>> 
> >>> So in the light of these findings we flagged noup, started all OSDs. At first there was no I/O. After 10 minutes we unset noup. All of 168 OSD started to make high I/O. And we thought that if we wait long enough it will finish & OSDs will be responsive again. After 24hours they did not because I/O did not finish or even slowed down.
> >>> One can think that is a lot of data there to scan. But it is just 33TB.
> >>> 
> >>> So at short we dont know which PG is stuck so we can remove it.
> >>> 
> >>> However we met an weird thing half an hour ago. We exported the same PG from two different OSDs. One was 4.2GB and the other is 500KB! So we decided to export all OSDs for backup. Then we will delete strange sized ones and start the cluster all over. Maybe then we could solve the stucked or unfound PGs as you advise.
> >>> 
> >>> Any thought would be greatly appreciated.
> >>> 
> >>> 
> >>>> On 2 Oct 2018, at 18:16, Darius Kasparavičius <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> 
> >>>> Hello,
> >>>> 
> >>>> Currently you have 15 objects missing. I would recommend finding them
> >>>> and making backups of them. Ditch all other osds that are failing to
> >>>> start and concentrate on bringing online those that have missing
> >>>> objects. Then slowly turn off nodown and noout on the cluster and see
> >>>> if it stabilises. If it stabilises leave these setting if not turn
> >>>> them back on.
> >>>> Now get some of the pg's that are blocked and querry the pgs to check
> >>>> why they are blocked. Try removing as much blocks as possible and then
> >>>> remove the norebalance/norecovery flags and see if it starts to fix
> >>>> itself. On Tue, Oct 2, 2018 at 5:14 PM by morphin
> >>>> <morphinwithyou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>>> 
> >>>>> One of ceph experts indicated that bluestore is somewhat preview tech
> >>>>> (as for Redhat).
> >>>>> So it could be best to checkout bluestore and rocksdb. There are some
> >>>>> tools to check health and also repair. But there are limited
> >>>>> documentation.
> >>>>> Anyone who has experince with it?
> >>>>> Anyone lead/help to a proper check would be great.
> >>>>> Goktug Yildirim <goktug.yildirim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 1 Eki 2018 Pzt, 22:55
> >>>>> tarihinde şunu yazdı:
> >>>>>> 
> >>>>>> Hi all,
> >>>>>> 
> >>>>>> We have recently upgraded from luminous to mimic. It’s been 6 days since this cluster is offline. The long short story is here: http://lists.ceph.com/pipermail/ceph-users-ceph.com/2018-September/030078.html
> >>>>>> 
> >>>>>> I’ve also CC’ed developers since I believe this is a bug. If this is not to correct way I apology and please let me know.
> >>>>>> 
> >>>>>> For the 6 days lots of thing happened and there were some outcomes about the problem. Some of them was misjudged and some of them are not looked deeper.
> >>>>>> However the most certain diagnosis is this: each OSD causes very high disk I/O to its bluestore disk (WAL and DB are fine). After that OSDs become unresponsive or very very less responsive. For example "ceph tell osd.x version” stucks like for ever.
> >>>>>> 
> >>>>>> So due to unresponsive OSDs cluster does not settle. This is our problem!
> >>>>>> 
> >>>>>> This is the one we are very sure of. But we are not sure of the reason.
> >>>>>> 
> >>>>>> Here is the latest ceph status:
> >>>>>> https://paste.ubuntu.com/p/2DyZ5YqPjh/.
> >>>>>> 
> >>>>>> This is the status after we started all of the OSDs 24 hours ago.
> >>>>>> Some of the OSDs are not started. However it didnt make any difference when all of them was online.
> >>>>>> 
> >>>>>> Here is the debug=20 log of an OSD which is same for all others:
> >>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> >>>>>> As we figure out there is a loop pattern. I am sure it wont caught from eye.
> >>>>>> 
> >>>>>> This the full log the same OSD.
> >>>>>> https://www.dropbox.com/s/pwzqeajlsdwaoi1/ceph-osd.90.log?dl=0
> >>>>>> 
> >>>>>> Here is the strace of the same OSD process:
> >>>>>> https://paste.ubuntu.com/p/8n2kTvwnG6/
> >>>>>> 
> >>>>>> Recently we hear more to uprade mimic. I hope none get hurts as we do. I am sure we have done lots of mistakes to let this happening. And this situation may be a example for other user and could be a potential bug for ceph developer.
> >>>>>> 
> >>>>>> Any help to figure out what is going on would be great.
> >>>>>> 
> >>>>>> Best Regards,
> >>>>>> Goktug Yildirim
> >>>>> _______________________________________________
> >>>>> ceph-users mailing list
> >>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>> 
> > 
> 
> 
--8323329-920813624-1538536483=:31802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-920813624-1538536483=:31802--
