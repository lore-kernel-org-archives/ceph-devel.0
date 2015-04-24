From: Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
Subject: Re: strange benchmark problem : restarting osd daemon
 improve performance from 100k iops to 300k iops
Date: Fri, 24 Apr 2015 13:49:56 -0400
Message-ID: <CANP1eJEtwXhs2QWd2dR8Gz+2eLqHO6oNZfHYHUnHvXh8NeKQ_w@mail.gmail.com>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
	<336199846.535234014.1429720226874.JavaMail.zimbra@oxygem.tv>
	<1806383776.554938002.1429776034371.JavaMail.zimbra@oxygem.tv>
	<1112295705.562655711.1429786696959.JavaMail.zimbra@oxygem.tv>
	<5538D86C.1090506@redhat.com>
	<1903663405.564474385.1429790186021.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD806BE@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAF-rypyB=CjjJQs_+3Q=ELCVwpg9nyWKdBu8gVyuDQa49=GHtw@mail.gmail.com>
	<1270073308.621430804.1429893511370.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1270073308.621430804.1429893511370.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 24, 2015 at 12:38 PM, Alexandre DERUMIER
<aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi,
>
> I have finished to rebuild ceph with jemalloc,
>
> all seem to working fine.
>
> I got a constant 300k iops for the moment, so no speed regression.
>
> I'll do more long benchmark next week.
>
> Regards,
>
> Alexandre


In my experience jemalloc is much more proactive at returning memory
to the OS, vs. tcmalloc in the default setting is much greedier with
keeping/reusing memory. jemalloc tends to do better if you application
benefits from a large page cache. Also, jemalloc's aggressive behavior
is better if you're running a lot of applications per host because
you're less likely to trigger a kernel dirty write out when allocating
space (because you're not keeping large free cached around per
application).

Howard of Symas and LMDB fame did some benchmarking and comparison
here: http://symas.com/mdb/inmem/malloc/ He came to somewhat similar
conclusions.

It would be helpful if you can reproduce the issue with tcmalloc...
Turn on tcmalloc stats logging (every 1GB allocated or so), then
compare the size to claimed by tcmalloc to process RSS size. If you
can account for a large difference, esp. multipled times a number of
OSD that may be the culprit.

I know things have gotten better in tcmalloc. As in they fixed a few
bugs where really large allocations were never returned to the OS and
the turned down the default greediness. Sadly, distros have slow at
picking these up in the past. If this is a problem it might be worth
to have an option to build tcmalloc (using a version know to be good)
into Ceph at build time.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org
