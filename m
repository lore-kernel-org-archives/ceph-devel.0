From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Wed, 24 Feb 2010 17:42:20 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5605@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
	<a37615151002231011i33a905c8qa338c4018752cc9e@mail.gmail.com>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002240654191.1887@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002240654191.1887@cobra.newdream.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

Besides the bug with the return value of write operation, the system hangs in a write operation.
You can access the trace files of ceph servers at 
https://sapmats-de.sap-ag.de/download/download.cgi?id=DHTK24DYMIH8MJEYGMO5GT1GKDLBR9IJDKFAA3R0C4D1JGTYVW
 
The traces were collected without "debug mds = 20" in the configuration file. I still have the hang system available. I also run the systems to regenerate the hang with "debug mds = 20" defined. 

It would be great if we could have a chat to resolve the hang in about 4 hours.

Thanks,
Roman

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Wednesday, February 24, 2010 4:56 PM
To: Talyansky, Roman
Cc: Yehuda Sadeh Weinraub; ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck

On Wed, 24 Feb 2010, Talyansky, Roman wrote:

> Hi Yehuda,
> 
> Thanks for the info on the fix. I'll incorporate it into the code and rerun the experiments.
> It also seems that the code at that location became a bit more complex - new #if occurred:
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 32)
> 
> And consequently the code under #else should be fixed as well.

Yeah.  I pushed this fix (and another fix that comes up when there's >1 
mds) to the stable 'master' branch of ceph-client.git and 
ceph-client-standalone.git.  The 'master-backport' branch of 
ceph-client-standalone.git has the backport #ifdefs (and builds back to 
2.6.28 or so).

Thanks!
sage


> 
> Thanks,
> 
> Roman
> 
> From: Yehuda Sadeh Weinraub [mailto:yehudasa@gmail.com]
> Sent: Tuesday, February 23, 2010 8:11 PM
> To: Talyansky, Roman
> Cc: Sage Weil; ceph-devel@lists.sourceforge.net
> Subject: Re: [ceph-devel] Write operation is stuck
> 
> 
> On Tue, Feb 23, 2010 at 6:11 AM, Talyansky, Roman <roman.talyansky@sap.com<mailto:roman.talyansky@sap.com>> wrote:
> Hi Sage,
> 
> As you advised us, we switched to the release 0.19 of ceph and ran into another bug in the ceph client. When writing to a file with the O_SYNC flag,  "0" is always returned although the data is written to disk.
> This poses a problem in our benchmark which uses the return value as number of bytes written. Also it seems that such behavior infringes the POSIX write() contract.
> 
> Yeah, thanks. A fix was pushed to the unstable branch. We will probably start maintaining a stable version that will contain such fixes, but you can apply this in the mean time:
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 2c4ae44..88932c9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -807,7 +807,7 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const struct iovec *iov,
>         struct ceph_osd_client *osdc = &ceph_client(inode->i_sb)->osdc;
>         loff_t endoff = pos + iov->iov_len;
>         int got = 0;
> -       int ret;
> +       int ret, err;
> 
>         if (ceph_snap(inode) != CEPH_NOSNAP)
>                 return -EROFS;
> @@ -838,9 +838,12 @@ retry_snap:
> 
>                 if ((ret >= 0 || ret == -EIOCBQUEUED) &&
>                     ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host)
> -                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL)))
> -                       ret = vfs_fsync_range(file, file->f_path.dentry,
> +                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
> +                       err = vfs_fsync_range(file, file->f_path.dentry,
>                                               pos, pos + ret - 1, 1);
> +                       if (err < 0)
> +                               ret = err;
> +               }
>         }
>         if (ret >= 0) {
>                 spin_lock(&inode->i_lock);
> 
> 
> 
> Yehuda
> 

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
