From: Sage Weil <sweil@redhat.com>
Subject: Re: debug coredump on teuthology
Date: Fri, 4 Nov 2016 13:22:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611041319550.20331@piezo.us.to>
References: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1081112541-1478265766=:20331"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761614AbcKDNWs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 09:22:48 -0400
In-Reply-To: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1081112541-1478265766=:20331
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 4 Nov 2016, kefu chai wrote:
> hi ceph developers,
> 
> i just pulled together a simple script at
> https://github.com/tchaikov/sepia-bt/blob/master/bt.sh for debugging
> the coredump on teuthology. what it does is
> 
> 1. download the ceph packages
> 2. extract them so we have the debugged executable and symbols
> 3. launch gdb and set the necessary paths
> 
> et voilà!
> 
> the idea of this script comes from badone (Brad). i just translate it
> into a shell script.
> 
> pull requests welcomed!

This is great!  Maybe we should put it in ceph.git/src/scripts?

sage
--8323329-1081112541-1478265766=:20331--
