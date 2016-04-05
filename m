From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Tue, 5 Apr 2016 14:57:34 +0200
Message-ID: <CABZ+qqkEMrWeQvgYC7eTsXvZY5zECaV7VC0nNiK8BfSSzfU+RQ@mail.gmail.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au> <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au> <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au> <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au> <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au> <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36186 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcDEM6S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 08:58:18 -0400
Received: by mail-lf0-f48.google.com with SMTP id g184so9848551lfb.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 05:58:17 -0700 (PDT)
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com. [209.85.217.179])
        by smtp.gmail.com with ESMTPSA id i2sm5414087lfd.43.2016.04.05.05.58.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2016 05:58:14 -0700 (PDT)
Received: by mail-lb0-f179.google.com with SMTP id qe11so8696341lbc.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 05:58:14 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 5, 2016 at 1:58 AM, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
> It's now clear that if you double the data size, you need to add one bit to your checksum to compensate.

Slight parenthesis: let's not forget that the messenger and OSD deep
scrubs use crc32c for potentially very large chunks of data. If
bluestore gets strong checksums we should try be consistent throughout
the code base.

--
Dan
