From: Sebastien Han <shan@redhat.com>
Subject: Ceph team involvement in Rook (Deploying Ceph in Kubernetes)
Date: Fri, 19 Jan 2018 11:49:05 +0100
Message-ID: <CA+HUO7JzYOaOGBfJhyotv7zPHFKxwm2WaFFS81AQGr4wPh48wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35416 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeASKt0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jan 2018 05:49:26 -0500
Received: by mail-vk0-f46.google.com with SMTP id n132so687601vke.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jan 2018 02:49:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, Squid Cybernetic <ceph-devel@vger.kernel.org>, Dan Mick <dmick@redhat.com>, "Chen, Huamin" <hchen@redhat.com>, John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>, bassam@tabbara.com

Everyone,

Kubernetes is getting bigger and bigger. It has become the platform of
choice to run microservices applications in containers, just like
OpenStack did for and Cloud applications in virtual machines.

When it comes to container storage there are three key aspects:

* Providing persistent storage to containers, Ceph has drivers in
Kuberntes already with kRBD and CephFS
* Containerizing the storage itself, so efficiently running Ceph
services in Containers. Currently, we have ceph-container
(https://github.com/ceph/ceph-container)
* Deploying the containerized storage in Kubernetes, we wrote
ceph-helm charts (https://github.com/ceph/ceph-helm)

The third piece although it's working great has a particular goal and
doesn't aim to run Ceph just like any other applications in Kuberntes.
We were also looking for a better abstraction/ease of use for
end-users, multi-cluster support, operability, life-cycle management,
centralized operations, to learn more you can read
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-October/021918.html.
As a consequence, we decided to look at what the ecosystem had to
offer. As a result, Rook came out, as a pleasant surprise. For those
who are not familiar with Rook, please visit https://rook.io but in a
nutshell, Rook is an open source orchestrator for distributed storage
systems running in cloud-native environments. Under the hood, Rook is
deploying, operating and managing Ceph life cycle in Kubernetes. Rook
has a vibrant community and committed developers.

Even if Rook is not perfect (yet), it has firm foundations, and we are
planning on helping to make it better. We already opened issues for
that and started doing work with Rook's core developers. We are
looking at reconciling what is available today
(rook/ceph-container/helm), reduce the overlap/duplication and all
work together toward a single and common goal. With this
collaboration, through Rook, we hope to make Ceph the de facto Open
Source storage solution for Kubernetes.

These are exciting times, so if you're a user, a developer, or merely
curious, have a look at Rook and send us feedback!

Thanks!
-- 
Cheers

––––––
Sébastien Han
Principal Software Engineer, Storage Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roquépine - 75008 Paris
