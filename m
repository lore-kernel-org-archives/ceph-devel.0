From: Artur Molchanov <artur.molchanov@synesis.ru>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Thu, 9 Feb 2017 18:51:39 +0300
Message-ID: <cfa74b42-b6d6-e658-9095-8e1cddf008fc@synesis.ru>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <CAOi1vP-7hcHAaVcqvLAcu9vL4ohQW4u9XoGdg-d5AuaX7E19Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36041 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbdBIQC3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 11:02:29 -0500
Received: by mail-lf0-f53.google.com with SMTP id z134so4988722lff.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2017 08:01:40 -0800 (PST)
In-Reply-To: <CAOi1vP-7hcHAaVcqvLAcu9vL4ohQW4u9XoGdg-d5AuaX7E19Dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya,

Currently we're working on moving our product to kubernetes / ceph stack. We're 
actively tuning ceph configuration and ceph cluster often need to be redeployed. 
We have to warm reboot all machines with mounted RBDs as a result. This patch 
allows us to remap and remount RBDs without time consuming reboot.

On 02/09/2017 05:27 PM, Ilya Dryomov wrote:
> What is the use case?  What do you expect this timeout to be in your
> environment?
