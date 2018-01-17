From: Huamin Chen <hchen@redhat.com>
Subject: REST API Client
Date: Wed, 17 Jan 2018 08:47:35 -0500
Message-ID: <CAD-gW==8X416nALGMunjXdjxsWCE+qRDm9+YfYUZ047mT4FrQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:45836 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeAQNrg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 08:47:36 -0500
Received: by mail-ot0-f169.google.com with SMTP id r4so13010888oti.12
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 05:47:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I am thinking of using Ceph REST API tclient o remove rbd cli
dependency from Kubernetes and rbd CSI driver.

The potential work flow is
- for rbd map, use sysfs
- use REST API client for rbd status, rbd create and rm

Questions: Does current Ceph REST server support these rbd calls? Has
anybody already worked on Golang client?

I found some early work on python client [1] but so far no work on
golang client. If I missed it, please let me know.


1. https://github.com/dmsimard/python-cephclient

Thanks

Huamin
