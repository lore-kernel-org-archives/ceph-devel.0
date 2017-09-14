From: Boris Ranto <branto@redhat.com>
Subject: Re: REST APIs
Date: Thu, 14 Sep 2017 15:33:34 +0200
Message-ID: <1505396014.391.8.camel@redhat.com>
References: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44988 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdINNdn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 09:33:43 -0400
Received: by mail-wr0-f179.google.com with SMTP id v109so5940437wrc.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 06:33:42 -0700 (PDT)
In-Reply-To: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I still plan to port the v1 endpoints from calamari to the restful
module so that it provides a full replacement for calamari rest api and
so that it could be used by projects like tendlr.

We do document the restful module in the RHCEPH product and several
people are/were interested in it. I did not hear of any product/app
being built on top of it yet though.

We can extend the pass through method in the restful module so that it
is more user friendly for a more robust/useful replacement of the ceph-
rest-api.

Regards,
Boris


On Wed, 2017-09-13 at 14:43 +0100, John Spray wrote:
> Hi all,
> 
> This message is prompted by: https://github.com/ceph/ceph/pull/17530
> 
> Questions:
>  - Is anyone using either ceph-rest-api or the restful module?
>  - Is anyone planning on doing any work on either?
>  - Is the CLI pass through of the restful module a sufficient
> replacement for ceph-rest-api for anyone that was using it?
> 
> John
