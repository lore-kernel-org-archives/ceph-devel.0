From: Samuel Just <sjust@redhat.com>
Subject: Re: sortbitwise
Date: Wed, 1 Jun 2016 15:48:57 -0700
Message-ID: <CAN=+7FUFoQnNLcUa1Brkt4vh4QbxgPNT6Nf=GvMvaKEq=9UiyA@mail.gmail.com>
References: <CAN=+7FVAAMZSeZDDeUdqt_cA7TR50jLWCnyh0ZjXXFrYzMNkBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35040 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcFAWs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 18:48:58 -0400
Received: by mail-qg0-f46.google.com with SMTP id e93so115428299qgf.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2016 15:48:58 -0700 (PDT)
In-Reply-To: <CAN=+7FVAAMZSeZDDeUdqt_cA7TR50jLWCnyh0ZjXXFrYzMNkBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weinstein, Yuri" <yweinste@redhat.com>, "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Or maybe they do?  I see hammer-x/tiering has it.  Do we run that one regularly?
-Sam

On Wed, Jun 1, 2016 at 3:47 PM, Samuel Just <sjust@redhat.com> wrote:
> I think the hammer-x tests aren't setting sortbitwise at all.  At
> least, I don't see it in the yamls.
> -Sam
