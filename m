From: Christian Huang <ythuang@gmail.com>
Subject: Re: CEPH RBD client kernel panic when OSD connection is lost on
 kernel 3.2, 3.5, 3.5.4
Date: Tue, 25 Sep 2012 12:33:30 +0800
Message-ID: <CAP5wSLcVt5AqbNoe=snK_2gCscAion-=s9YuPQo_KeYNVCx+oQ@mail.gmail.com>
References: <CAP5wSLcy90qhsTnNxM=t+_SB1kpfNvchrSqdAG91P6tCe0RPRA@mail.gmail.com>
	<5060E5B5.8040807@inktank.com>
	<CAP5wSLeuLhJxrqmiaz8-4SXo_Sfzs8xY23UMO2O7vivnBMNDBg@mail.gmail.com>
	<50612747.6090805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55702 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2IYEda (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 00:33:30 -0400
Received: by ieak13 with SMTP id k13so12905404iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 21:33:30 -0700 (PDT)
In-Reply-To: <50612747.6090805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex,
   is this issue what you are referring to?
   http://tracker.newdream.net/issues/2260

   we will give the patch a try and see if resolves the issue.

Best Regards.
Chris.

On Tue, Sep 25, 2012 at 11:38 AM, Alex Elder <elder@inktank.com> wrote:
> On 09/24/2012 08:25 PM, Christian Huang wrote:
>> Hi Alex,
>>     we have used several kernel versions, some built from source,
>>     some stock kernel, from ubuntu repository.
>>
>>     for the version you are referring to, we used a stock kernel from
>> ubuntu repository.
>>
>>     for building from source, we follow instructions from this page
>>     http://blog.avirtualhome.com/compile-linux-kernel-3-2-for-ubuntu-11-10/
>>     and use the following tag from precise git repo.
>>     Ubuntu-3.2.0-29.46
>
> These two bits of information:
>
>>     please also note that we reproduced the issue with kernel 3.5.4
>> from kernel ppa
>>     http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.5.4-quantal/
>>
>>     it seems the following version does not have the issue
>>     http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.6-rc7-quantal/
>
> ...are very helpful.
>
> There is a very important bug that got fixed between those two
> releases, and it has symptoms like what you are reporting.
> I can't say with 100% confidence that you are hitting this, but
> it it appears you could be.
>
> The fix is very simple, and you should be able to patch your own
> code to check to see if it makes the problem go away.  If you
> do, please report back whether you find it fixes the problem.
>
> Tomorrow I'll see if I can trace the particulars of the problem
> you are reporting to this issue.
>
>                                         -Alex
>
> From 02f7c002c9af475df6b2a1b64066bcdaf53cb7dc Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Wed, 6 Jun 2012 19:35:55 -0500
> Subject: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
>
> The bug can cause NULL pointer dereference in write_partial_msg_pages
>
> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
> Reviewed-by: Alex Elder <elder@inktank.com>
> (cherry picked from commit 43643528cce60ca184fe8197efa8e8da7c89a037)
> ---
>  net/ceph/messenger.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f0e34ff..d372b34 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -563,6 +563,10 @@ static void prepare_write_message(struct
> ceph_connection *con)
>                 m->hdr.seq = cpu_to_le64(++con->out_seq);
>                 m->needs_out_seq = false;
>         }
> +#ifdef CONFIG_BLOCK
> +       else
> +               m->bio_iter = NULL;
> +#endif
>
>         dout("prepare_write_message %p seq %lld type %d len %d+%d+%d %d pgs\n",
>              m, con->out_seq, le16_to_cpu(m->hdr.type),
> --
> 1.7.9.5
>
>
>
>
>> Best Regards.
>> Chris.
>> On Tue, Sep 25, 2012 at 6:59 AM, Alex Elder <elder@inktank.com> wrote:
>>> On 09/24/2012 05:23 AM, Christian Huang wrote:
>>>> Hi,
>>>>     we met the following issue while testing ceph cluster HA.
>>>>     Appreciate if anyone can shed some light.
>>>>     could this be related to the configuration ? (ie, 2 OSD nodes only)
>>>
>>> It appears to me the kernel that was in use for the crash logs
>>> you provided was built from source.  If that is the case, are you
>>> able to provide me with the precise commit id so I am sure to
>>> be working with the right code?
>>>
>>> Here is a line that leads me to that conclusion:
>>>
>>> [  203.172114] Pid: 1901, comm: kworker/0:2 Not tainted 3.2.0-29-generic
>>> #46-Ubuntu Wistron Cloud Computing/P92TB2
>>>
>>> If you wish I would be happy to work with one of the other versions
>>> of the code, but would prefer to also have crash information that
>>> matches the source code I'm looking at.  Thank you.
>>>
>>>                                         -Alex
>>>
>>>
>>>>     Issue description:
>>>>     ceph rbd client will kernel panic if an OSD server loses it's
>>>> network connectivity.
>>>>     so far, we can reproduce it with certainty.
>>>>     we have tried with the following kernels
>>>>     a. Stock kernel from 12.04 (3.2 series)
>>>>         3.5 series, as suggested in a previous mail by Sage
>>>>     b. 3.5.0-15 from quantal repo,
>>>> git://kernel.ubuntu.com/ubuntu/ubuntu-quantal.git, Ubuntu-3.5.0-15.22
>>>> tag
>>>>     c. v3.5.4-quantal,
>>>> http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.5.4-quantal/
>>>>
>>>>     Environment:
>>>>     OS: Ubuntu 12.04 precise pangolin
>>>>     Ceph configuration:
>>>>         OSD nodes: 2 x 12 drives , 1 os drive, 11 are mapped to OSD
>>>> 0-10, 10GbE link
>>>>         Monitor nodes: 3 x KVM virtual machines on ubuntu host.
>>>>         test client: fresh install of Ubuntu 12.04.1
>>>>         Ceph version used: 0.48, 0.48.1, 0.48.2, 0.51
>>>>         all nodes have the same kernel version.
>>>>
>>>>     steps to reproduce:
>>>>     on the test client,
>>>>     1. load rbd modules
>>>>     2. create rbd device
>>>>     3. map rbd device
>>>>     4. use fio tool to create work load on the device, 8 threads is
>>>> used for workload
>>>>         we have also tried with iometer, 8 workers, 32k 50/50, same results.
>>>>
>>>>     on one of the OSD nodes,
>>>>     1. sudo ifconfig eth0 down #where eth0 is the primary interface
>>>> configured for ceph.
>>>>     2. within 30 seconds, the test client will panic.
>>>>
>>>>     this happens when there is IO activity on the RBD device, and one
>>>> of the OSD nodes loses connectivity.
>>>>
>>>>     The netconsole output is available available from the following
>>>> dropbox link,
>>>>     zip: goo.gl/LHytr
>>>>
>>>> Best Regards
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>
