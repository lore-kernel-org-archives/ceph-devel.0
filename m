From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: straw2-like algorithm
Date: Tue, 19 May 2015 16:13:21 +0300
Message-ID: <CAOi1vP89u3MZrCzyeL54aSRZX=qT+Uju1K3Xo+td6_irrWBmrg@mail.gmail.com>
References: <DB3PR03MB06841B94BC544DA1466E1E95D4C70@DB3PR03MB0684.eurprd03.prod.outlook.com>
	<CAC6JEv_+63VOuTN=PgOahWE-KZT=oRvpzux_M0MPbrEbwUeVsg@mail.gmail.com>
	<DB3PR03MB0684C61FF0F0755A66AB1322D4C30@DB3PR03MB0684.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33881 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbESNNW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 09:13:22 -0400
Received: by wicmc15 with SMTP id mc15so116400677wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 06:13:21 -0700 (PDT)
In-Reply-To: <DB3PR03MB0684C61FF0F0755A66AB1322D4C30@DB3PR03MB0684.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Artem Elkin <Artem.Elkin@icl-services.com>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 19, 2015 at 3:26 PM, Artem Elkin
<Artem.Elkin@icl-services.com> wrote:
> Yes, current implementation is very optimized and tricky. But it uses two lookup table. So the question is what the system does between the choose function calls. In case there are some memory intensive operations between them the tables are likely to be displaced from the CPU caches. Another question is if this stuff has any visible impact on the overall performance (how often is it called?). I'm not aware of such details so you are the ones who should make the decision.

It may be called more than once for every request going to the OSDs,
so it certainly has a visible impact on the overall performance.

Thanks,

                Ilya
