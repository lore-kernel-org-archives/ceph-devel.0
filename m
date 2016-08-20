From: Srikar Somineni <srikar.kumar@gmail.com>
Subject: Ceph_Manual_Installation
Date: Sat, 20 Aug 2016 13:27:45 +0530
Message-ID: <CABu999x_51PSKE40NK6p8CmC+2=Hf2xmfOONqPP43GqTPmCSQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34000 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbcHTH5s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Aug 2016 03:57:48 -0400
Received: by mail-lf0-f44.google.com with SMTP id l89so46797632lfi.1
        for <ceph-devel@vger.kernel.org>; Sat, 20 Aug 2016 00:57:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,
          As a person new to Ceph, I am trying to build Ceph from
source code while adding debugs. I have been going through Ceph
documents mentioned below.

http://docs.ceph.com/docs/master/install/build-ceph/
http://docs.ceph.com/docs/master/install/install-storage-cluster/#installing-a-build

What I gathered is that, after giving "make" and finally "make
install" we will install Ceph libraries in /usr/lib (for an Linux
system). These changes will take place on local user space only .
I want to install Ceph over an entire cluster. I have a cluster
consisting of one Admin and Monitor node and three OSD nodes. I am
building Ceph on Admin node . I want to install the built in Ceph code
on the entire cluster. Can anyone help me how to proceed  further with
my issue here. Do I need to make the built code as a local repository
and use ceph-deploy to install on the cluster?
Thanks in Advance.

Regards,
S.Srikar.
