From: Haomai Wang <haomai@xsky.com>
Subject: Re: [on-the-wire]Can not pass 'make check'
Date: Sat, 14 May 2016 09:44:00 +0800
Message-ID: <CACJqLyaJLJcbcQJBNGJz_vLQ4r4iAS33q-SnDiwuQTNpUMNEdQ@mail.gmail.com>
References: <CAEG8a3KwK1nMbmFm2WFjNPuFaET22yeafJJG29YddWkUdh00PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0118.outbound.protection.outlook.com ([104.47.126.118]:41938
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753345AbcENBoO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 May 2016 21:44:14 -0400
Received: by mail-vk0-f49.google.com with SMTP id f66so157620101vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2016 18:44:08 -0700 (PDT)
In-Reply-To: <CAEG8a3KwK1nMbmFm2WFjNPuFaET22yeafJJG29YddWkUdh00PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Junwang Zhao <zhjwpku@gmail.com>
Cc: "Sage A. Weil" <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, May 14, 2016 at 9:26 AM, Junwang Zhao <zhjwpku@gmail.com> wrote:
> Hi Sage, Haomai,
>
> I am trying to test this patch[1], which I have modified after Sage's comments,
> I rebased this branch to the ceph/master yestoday, it can build but 'make check'
> got some 'FAIL' and stuck at some point hardly move on, see the attachment.

Although I'm not sure the reason should be related to env, I think
it's not caused by your commits.

Go ahead:-)


>
> Need some help, thanks!
>
> [1]https://github.com/zhjwpku/ceph/commit/6d3c429de80c23afb2612f01536ef6140fe5d3c2
