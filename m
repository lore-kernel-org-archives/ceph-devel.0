From: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
 objects in pool
Date: Mon, 20 Jun 2016 09:52:29 +0900
Message-ID: <20160620095229.5291bdc6@batzmaru.gol.ad.jp>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


Hello Blair,

On Mon, 20 Jun 2016 09:21:27 +1000 Blair Bethwaite wrote:

> Hi Wade,
> 
> (Apologies for the slowness - AFK for the weekend).
> 
> On 16 June 2016 at 23:38, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
> >
> >> Op 16 juni 2016 om 14:14 schreef Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>
> >>
> >> Hi All,
> >>
> >> I have a repeatable condition when the object count in a pool gets to
> >> 320-330 million the object write time dramatically and almost
> >> instantly increases as much as 10X, exhibited by fs_apply_latency
> >> going from 10ms to 100s of ms.
> >>r filestore
> >
> > My first guess is the filestore splitting and the amount of files per
> > directory.
> 
> I concur with Wido and suggest you try upping your filestore split and
> merge threshold config values.
>
This is probably a good idea but as mentioned/suggested below, it would
be something that eventually settle down in a new equilibrium.
Something I don't think is happening here. 
 
> I've seen this issue a number of times now with write heavy workload,
> and would love to at least write some docs about it, because it must
> happen to a lot of users running RBD workloads on largish drives.
> However, I'm not sure how to definitively diagnose the issue and
> pinpoint the problem. The gist of the issue is the number of files
> and/or directories on your OSD filesystems, at some system dependent
> threshold you get to a point where you can no longer sufficiently
> cache inodes and/or dentrys, so IOs on those files(ystems) have to
> incur extra disk IOPS to read the filesystem structure from disk (I
> believe that's the small read IO you're seeing, and unfortunately it
> seems to effectively choke writes - we've seen all sorts of related
> slow request issues). If you watch your xfs stats you'll likely get
> further confirmation. In my experience xs_dir_lookups balloons (which
> means directory lookups are missing cache and going to disk).
> 
> What I'm not clear on is whether there are two different pathologies
> at play here, i.e., specifically dentry cache issues versus inode
> cache issues. In the former case making Ceph's directory structure
> shallower with more files per directory may help (or perhaps
> increasing the number of PGs - more top-level directories), but in the
> latter case you're likely to need various system tuning (lower vfs
> cache pressure, more memory?, fewer files (larger object size))
> depending on your workload.
> 
I can very much confirm this from the days when on my main production
cluster all 1024 PGs (but only about 6GB of data and 1.6 million objects)
were on just 4 OSDs (25TB each).

Once SLAB ran out of steam and couldn't hold all the respective entries
(Ext4 here, but same diff), things became very slow.

My litmus test is that a "ls -R /var/lib/ceph/osd/ceph-nn/ >/dev/null"
should be pretty much instantaneous and not having to access the disk at
all.

More RAM and proper tuning as well as smaller OSDs are all ways forward to
alleviate/prevent this issue.

It would be interesting to see/know how bluestore fares in this kind of
scenario.

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi-FW+hd8ioUD0@public.gmane.org   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
