From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [PATCH 17/18] client: Write inline data path
Date: Mon, 02 Dec 2013 16:20:39 +0800
Message-ID: <529C42D7.6040108@ubuntukylin.com>
References: <938803040.82.1385744469623.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:55772 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3LBIUn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Dec 2013 03:20:43 -0500
In-Reply-To: <938803040.82.1385744469623.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Zheng Yan <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Hi Matt,
   This feature is expected to run in the massive tiny file storage 
situation, and there are some further designs to reduce the overhead 
when the file is not tiny,
(1) The migration is done asynchronously with the subsequent read/write 
(v3);
(2) Avoid migration when the inline data length be zero, that will 
capture some situations to almost eliminate the migration overhead (v4);
(3) It could be implicitly turned off at mount time by client (v4);
(4) It could be turned off globally by configuring the mds(v4).

v4 is coming soon.

Cheers,
Li Wang

On 11/30/2013 01:01 AM, Matt W. Benjamin wrote:
> Hi,
>
> I wondered about this.  Were you able to measure an effect?
>
> Thanks,
>
> Matt
>
> ----- "Zheng Yan" <ukernel@gmail.com> wrote:
>
>>
>> Besides, this feature should be disabled by default because it's not
>> compatible with old clients and it imposes overhead on the mds. we
>> need to use a config option or directory attribute to enable it.
>>
>> Regards
>> Yan, Zheng
>>
>
