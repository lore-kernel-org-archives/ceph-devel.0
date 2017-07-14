From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: release v12.1.1?
Date: Fri, 14 Jul 2017 22:53:02 +0200
Message-ID: <630410bf-037c-d76e-e249-c021baa98c43@digiware.nl>
References: <CALqRxCwq_qhLFuUnrNNLgM+qZ-oixDmaUgf9e6e+dP1EeXfKJQ@mail.gmail.com>
 <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:24798 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdGNUxE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Jul 2017 16:53:04 -0400
In-Reply-To: <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 14-7-2017 22:13, Sage Weil wrote:
> Yes!  I was hoping to get the missing deletes in there but there is plenty 
> to justify the next rc.

If possible I would really like to get #15339 in.
Sinec this commit sort of completes a milestone for the FreeBSD port, in
that it is not only serverside with rgw stuff. But also the part that is
more targeted to virtual machines.

It's been tested manually with
  - the testscript Mykola wrote
  - iozone and bonnie
  - pjdfstest
  - rsync loading
	
--WjW


