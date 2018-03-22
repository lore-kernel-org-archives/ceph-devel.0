From: =?iso-2022-jp?B?GyRCNTUwZj9OO1YbKEIgLyBLQU1FSRskQiEkGyhCSElUT1NISQ==?=
        <hitoshi.kamei.xm@hitachi.com>
Subject: RE: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Date: Thu, 22 Mar 2018 11:57:27 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5AB0E4F3.8090108@easystack.cn>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, "idryomov@gmail.com" <idryomov@gmail.com>, "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi Yang, 

> I am not sure is this the best way for this case, what about adding an option in "rbd map -o thick rbd/test"?

I will add such option to the rbd map command to manipulate image settings. So, the end-user
do not change the settings directly via sysfs file.

>	@@ -4011,6 +4012,15 @@ static void rbd_queue_workfn(struct work_struct *work)
>	 		goto err;
>	 	}
>	
>	+	/* Ignore/skip discard requests for thick-provision image */
>
> Just ignore? or return -EOPNOTSUPP? 

Thanks, I think -EOPNOTSUPP is better because user programs cannot know
the result of requested operation when the kernel rbd driver ignores
discard request. The result of requested operation when the kernel rbd driver
ignores discard requests, which probably misleads the user programs.

> In addition, we should not ignore the REQ_OP_WRITE_ZEROES.

Relating to the above, the return code of REQ_OP_WRITE_ZEROS request
is also -EOPNOTSUPP instead of ignoring. I think the result of
-EOPNOTSUPP is also better for this request because the kernel
rbd driver can expect that user programs write zero data by itself.

>	+	spin_lock_irq(&rbd_dev->lock);
>	+	if (!strncmp(buf, "1", size))
>	+		set_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
>	+	else if (!strncmp(buf, "0", size))
>	+		clear_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
> else ?

I will add the warning message in else case.
	
>	 static DEVICE_ATTR(snap_id, S_IRUGO, rbd_snap_id_show, NULL);
>	 static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
>	+static DEVICE_ATTR(thick, 0644, rbd_thick_show, rbd_thick_store);
> maybe S_IRUGO | S_IWUGO?

I will change the code by using the flags.

Regards,

-- 
Hitoshi Kamei
