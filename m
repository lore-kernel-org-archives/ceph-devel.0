From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: Ceph on btrfs 3.4rc
Date: Thu, 24 May 2012 11:37:18 +0200
Message-ID: <CAJafhzQukXh+-DyoKzcmPDU+Yh8nADywGmJ_0SA_efc9v7Nwgw@mail.gmail.com>
References: <20120517194358.GA9846@dhcp231-144.rdu.redhat.com>
	<CAJafhzTQJchdd600DiEnooUH-P9ZcLvW+oEczCMNskd+Ud4BmQ@mail.gmail.com>
	<4FB56B21.7070800@tuxadero.com>
	<20120518144759.GA1892@localhost.localdomain>
	<4FB685C9.2050607@tuxadero.com>
	<20120518190105.GB1892@localhost.localdomain>
	<4FB9BDBA.2030806@cn.fujitsu.com>
	<CAJafhzSmLC9yUwrxsJEz5vKYnfP0DSWdMnA0oXmLT_4CQFc1oQ@mail.gmail.com>
	<20120522173344.GB1890@localhost.localdomain>
	<CAJafhzQGHsSA6dUwOqTJERj7SgVmKFuVDHk5R+i7n0FuhUAj_g@mail.gmail.com>
	<20120523150235.GB2127@localhost.localdomain>
	<4FBD3681.5060000@tuxadero.com>
	<4FBDCF35.6060409@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <4FBDCF35.6060409@tuxadero.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Same thing here.

I've tried really hard, but even after 12 hours I wasn't able to get a
single warning from btrfs.

I think you cracked it!

Thanks,
Christian

2012/5/24 Martin Mailand <martin@tuxadero.com>:
> Hi,
> the ceph cluster is running under heavy load for the last 13 hours without a
> problem, dmesg is empty and the performance is good.
>
> -martin
>
> Am 23.05.2012 21:12, schrieb Martin Mailand:
>
>> this patch is running for 3 hours without a Bug and without the Warning.
>> I will let it run overnight and report tomorrow.
>> It looks very good ;-)
