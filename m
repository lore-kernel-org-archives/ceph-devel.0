From: "=?utf-8?Q?Alex=E2=80=8E_Nelson?=" <ajnelso1@npscloud.net>
Subject: Re: Can't creat file on client
Date: Mon, 28 Feb 2011 07:34:07 -0800
Message-ID: <93707D9C-BA3B-414A-8A84-4BB62BCC48B5@cs.ucsc.edu>
References: <AANLkTimjVL0t6ayQJWp1suwS25fW9pf3dcL3ESc_kyDo@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39016 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1B1PeZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Feb 2011 10:34:25 -0500
Received: by fxm17 with SMTP id 17so3839481fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 07:34:24 -0800 (PST)
In-Reply-To: <AANLkTimjVL0t6ayQJWp1suwS25fW9pf3dcL3ESc_kyDo@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

The directory permissions probably aren't starting as you expect them to.  sudo chmod the Ceph root permissions and you should be good to go.

IIRC, they always start as 000 when making a fresh file system.

--Alex


On Feb 28, 2011, at 05:41 , Qian Wei wrote:

> Recently,I install ceph on to two fedoras on vmware,
> one for install ceph_client
> one for install ceph_mon&mds&osd
> altough successfully done : mount -t ceph /mnt/ceph root@ceph_mon&mds&osd
> and input df -h ,I can see the mount ceph device,
> but while I input command:
> $touch /mnt/ceph/abc
> then returned error: touch: cannot touch `abc': Permission denied
> Is there anyone can help me resolve the problem?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

