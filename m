From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] vfs: Add support for timestamp limits
Date: Fri, 30 Aug 2019 15:58:35 +0200
Message-ID: <CAK8P3a0NMUv2xOw=fCxJXo_2wbmBMG24Fst3U1LT-m7C8uxz0w@mail.gmail.com>
References: <20190829041132.26677-1-deepa.kernel@gmail.com>
 <CABeXuvoKD83B7iUqE33Y9E2OVtf61DKv-swZr-N=ozz-cMmGOA@mail.gmail.com>
 <CAOg9mSR25eAH7e1KhDZt_uscJSzyuSmELbCxgyh=-KWRxjZtcw@mail.gmail.com>
 <CABeXuvpe9vADLZUr4zHrH0izt=1BaLQvBMxAu=T1A2CV3AN4vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <CABeXuvpe9vADLZUr4zHrH0izt=1BaLQvBMxAu=T1A2CV3AN4vA@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, jfs-discussion@lists.sourceforge.net, Dave Kleikamp <shaggy@kernel.org>, Anders Larsen <al@alarsen.net>, Bob Copeland <me@bobcopeland.com>, Adrian Hunter <adrian.hunter@intel.com>, Andreas Dilger <adilger.kernel@dilger.ca>, mikulas@artax.karlin.mff.cuni.cz, stoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org, "Yan,
 Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, y2038 Mailman List <y2038@lists.linaro.org>, Richard Weinberger <richard@nod.at>, Steve French <sfrench@samba.org>, Anton Vorontsov <anton@enomsg.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, codalist@coda.cs.cmu.edu, Christoph Hellwig <hch@infradead.org>, coda@cs.cmu.edu, V9FS Developers <v9fs-develo>
List-Id: ceph-devel.vger.kernel.org

On Fri, Aug 30, 2019 at 4:02 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Thu, Aug 29, 2019 at 6:20 PM Mike Marshall <hubcap@omnibond.com> wrote:
> >
> > Hi Deepa...
> >
> > I installed this patch series on top of Linux 5.3-rc6 and ran xfstests
> > on orangefs and got a regression... generic/258 failed
> > with: "Timestamp wrapped"...
> >
> > # cat results/generic/258.out.bad
> > QA output created by 258
> > Creating file with timestamp of Jan 1, 1960
> > Testing for negative seconds since epoch
> > Timestamp wrapped: 0
> > Timestamp wrapped
> > (see /home/hubcap/xfstests-dev/results//generic/258.full for details)
>
> Note that patch [16/20] https://lkml.org/lkml/2019/8/18/193 assumes
> that orangefs does not support negative timestamps.
> And, the reason was pointed out in the commit text:
>
> ----------------------
> Assume the limits as unsigned according to the below
> commit 98e8eef557a9 ("changed PVFS_time from int64_t to uint64_t")
> in https://github.com/waltligon/orangefs
>
> Author: Neill Miller <neillm@mcs.anl.gov>
> Date:   Thu Sep 2 15:00:38 2004 +0000
> --------------------
>
> So the timestamp being wrapped to 0 in this case is correct behavior
> according to my patchset.
> The generic/258 assumes that the timestamps can be negative. If this
> is not true then it should not be run for this fs.
>
> But, if you think the timestamp should support negative timestamps for
> orangefs, I'd be happy to change it.

I think it's unclear from the orangefs source code what the intention is,
as there is a mixed of signed and unsigned types used for the inode
stamps:

#define encode_PVFS_time encode_int64_t
#define encode_int64_t(pptr,x) do { \
    *(int64_t*) *(pptr) = cpu_to_le64(*(x)); \
    *(pptr) += 8; \
} while (0)
#define decode_PVFS_time decode_int64_t
#define decode_int64_t(pptr,x) do { \
    *(x) = le64_to_cpu(*(int64_t*) *(pptr)); \
    *(pptr) += 8; \
} while (0)

This suggests that making it unsigned may have been an accident.

Then again,  it's clearly and consistently printed as unsigned in
user space:

        gossip_debug(
            GOSSIP_GETATTR_DEBUG, " VERSION is %llu, mtime is %llu\n",
            llu(s_op->attr.mtime), llu(resp_attr->mtime));

A related issue I noticed is this:

PVFS_time PINT_util_mktime_version(PVFS_time time)
{
    struct timeval t = {0,0};
    PVFS_time version = (time << 32);

    gettimeofday(&t, NULL);
    version |= (PVFS_time)t.tv_usec;
    return version;
}
PVFS_time PINT_util_mkversion_time(PVFS_time version)
{
    return (PVFS_time)(version >> 32);
}
static PINT_sm_action getattr_verify_attribs(
        struct PINT_smcb *smcb, job_status_s *js_p)
{
...
    resp_attr->mtime = PINT_util_mkversion_time(s_op->attr.mtime);
...
}

which suggests that at least for some purposes, the mtime field
is only an unsigned 32-bit number (1970..2106). From my readiing,
this affects the on-disk format, but not the protocol implemented
by the kernel.

atime and ctime are apparently 64-bit, but mtime is only 32-bit
seconds, plus a 32-bit 'version'. I suppose the server could be
fixed to allow a larger range, but probably would take it out of
the 'version' bits, not the upper half.

To be on the safe side, I suppose the kernel can only assume
an unsigned 32-bit range to be available. If the server gets
extended beyond that, it would have to pass a feature flag.

     Arnd
