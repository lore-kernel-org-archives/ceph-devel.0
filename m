From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Hard to debug problem with ceph_erasure_code
Date: Fri, 1 Apr 2016 08:12:06 +0300
Message-ID: <20160401051205.GA29567@gmail.com>
References: <56FD5A15.1080507@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36246 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcDAFMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 01:12:10 -0400
Received: by mail-lb0-f195.google.com with SMTP id q4so8478119lbq.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 22:12:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FD5A15.1080507@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 31, 2016 at 07:10:45PM +0200, Willem Jan Withagen wrote:

> Does anybody have suggestions as how to track/debug this?

valgrind?

-- 
Mykola Golub
