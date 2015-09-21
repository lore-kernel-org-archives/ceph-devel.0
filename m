From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: ./src/vstart.sh
Date: Mon, 21 Sep 2015 09:22:07 +0300
Message-ID: <20150921062206.GA23240@gmail.com>
References: <545828772.19046223.1442807824240.JavaMail.zimbra@redhat.com>
 <1540172490.19046862.1442808063693.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33811 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbIUGWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Sep 2015 02:22:10 -0400
Received: by wicfx3 with SMTP id fx3so130394428wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2015 23:22:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1540172490.19046862.1442808063693.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 21, 2015 at 12:01:03AM -0400, Shinobu Kinjo wrote:
> Whenever I run vstart.sh, there are always 2 [global] sections in ./src/ceph.conf.
> First one makes sense but second one is just empty.
> 
> Is it supposed to be? If so what's the purpose of second one?

The second one is for extra config parameters, which are specified via
command line like below:

  ./vstart.sh -n -o 'debug ms = 20'

The section is at the bottom so it could override options set in the
config earlier.

-- 
Mykola Golub
