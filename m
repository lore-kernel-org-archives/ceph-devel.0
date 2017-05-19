From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [GSOC] ceph-mgr: Cluster Status Dashboard
Date: Fri, 19 May 2017 14:22:48 +0200
Message-ID: <CABZ+qqmeEDVQFy3X7YZ1jn8UzgniF+4pi1p77fxcgrNeBCNg0A@mail.gmail.com>
References: <CA+b5B08BdnpZvbnWS+ocr2oObG4moc0nGibGwm6Taq9Eh=46wg@mail.gmail.com>
 <CALe9h7esz4MquzA6ZqCniOj8jb=j+7QdhnSkLTj+2d9HCyYtFw@mail.gmail.com>
 <CA+b5B089q0sbcF07Di2-4JroUjZNNekvAa2SeOQvWgB7X8wqaQ@mail.gmail.com>
 <CAEYCsVLV7zA+9-9D-LGe=Myub4Qf49fUDdMOdDrA7DD6411DDw@mail.gmail.com> <alpine.DEB.2.11.1705191215090.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36602 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdESMXa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 08:23:30 -0400
Received: by mail-oi0-f51.google.com with SMTP id h4so89660606oib.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 05:23:30 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id l135sm4044040oib.4.2017.05.19.05.23.28
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2017 05:23:28 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id l18so89683163oig.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 05:23:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705191215090.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Xiaoxi Chen <superdebuger@gmail.com>, saumay agrawal <saumay.agrawal@gmail.com>, John Spray <jspray@redhat.com>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 2:18 PM, Sage Weil <sage@newdream.net> wrote:
> I'm also curious how the grafana dashboards are built (I haven't used
> Grafana before).  Is this the sort of thing where the dashboards can be
> developed and managed in source control?  It would be great to have a
> bunch of pre-built and collaboratively developed Ceph dashboards!

A grafana dashboard is described by a json file, which can exported
and shared, e.g. at https://grafana.com/dashboards

-- dan
