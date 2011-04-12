From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just
 librados
Date: Tue, 12 Apr 2011 11:28:26 -0700
Message-ID: <4DA499CA.9080201@dreamhost.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>	<20110408084334.GA28360@stefanha-thinkpad.localdomain>	<4DA39A6A.7020403@dreamhost.com> <BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54026 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360Ab1DLS21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 14:28:27 -0400
In-Reply-To: <BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>

On 04/12/2011 01:54 AM, Stefan Hajnoczi wrote:
> Is qemu-iotests passing for you now?

Yes, they all pass when 016 is skipped.

Josh
