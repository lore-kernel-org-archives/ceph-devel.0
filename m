From: Jin Cai <caijin.laurence@gmail.com>
Subject: create rbd image failed
Date: Thu, 29 Sep 2016 21:50:22 +0800
Message-ID: <CAGRcXKae+VgEoGhNb_kTBAbPm_hb1Q=+wPZXR6-h6_W6YmnQfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35337 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbcI2NuX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 09:50:23 -0400
Received: by mail-vk0-f42.google.com with SMTP id 192so75046607vkl.2
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 06:50:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@redhat.com, ceph-devel@vger.kernel.org

Hi,
To use erasure coding in rbd, I created a cache pool with the read-only mode.
But when I created a rbd image for the cache pool, there was an
unexpected error:


rbd create -p cache-pool --image cache-image --image-format 2
--object-size 16K --image-feature layering --size 5G
2016-09-29 21:20:03.437598 7f5b9d150d80 -1 librbd: error writing
header: (95) Operation not supported
rbd: create error: (95) Operation not supported


I think it is due to the reason that setting cache pool in read-only
mode, but I do not know why it is. Did someone face the same situation
before?
Regards
