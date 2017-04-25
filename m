From: Yann Dupont <yd@objoo.org>
Subject: Re: jewel 10.2.8 last call
Date: Tue, 25 Apr 2017 21:32:34 +0200
Message-ID: <0015fa14-1baa-f79f-0a95-3a7a904b8c6b@objoo.org>
References: <18bf7357-dfbd-2def-ee9c-506e67fc24e0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:53096 "EHLO
        smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1430748AbdDYTl3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 15:41:29 -0400
In-Reply-To: <18bf7357-dfbd-2def-ee9c-506e67fc24e0@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Le 25/04/17 à 07:00, Nathan Cutler a écrit :
> In the interests of getting jewel 10.2.8 released sooner rather than 
> later, if there is anything you would like to get in, please let me 
> know by replying to this message.

Hi, Nathan.
AFAICT, this one still isn't merged :

https://github.com/ceph/ceph/commit/793ceac2f3d5a2c404ac50569c44a21de6001b62


This is quite simple, but without it, tiering throttling isn't working 
the way it should.

Cheers,
Yann.

