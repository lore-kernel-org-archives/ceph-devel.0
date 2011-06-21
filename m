From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: error: =?UTF-8?Q?=27pthread=5Fspin=5Flock=27=20does=20not=20n?=
 =?UTF-8?Q?ame=20a=20type?=
Date: Tue, 21 Jun 2011 09:31:03 -0500
Message-ID: <392b4440e51cad5a7cbefe18f47d2232@localhost>
References: <44eba4c7dce082b9d25c96de62ead304@pl1.haspere.com>
 <BANLkTimc_PUHPbYT2+Wcwwb47bEqxtD+uQ@mail.gmail.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:37050 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab1FUObE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jun 2011 10:31:04 -0400
In-Reply-To: <BANLkTimc_PUHPbYT2+Wcwwb47bEqxtD+uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi Colin,

 With your patch, Ceph compiles correctly with the libatomic configure 
 switch present and not present.  (I didn't know about that before.)

 ---
 Thanks,
 Dyweni


 On Mon, 20 Jun 2011 22:36:35 -0700, Colin Patrick McCabe wrote:

> Hi Dyweni,
>
> It seems that you do not have libatomic ops, so you spotted a build
> error that I overlooked.
> Thanks for the report, it should be fixed shortly.
>
> cheers,
> Colin

