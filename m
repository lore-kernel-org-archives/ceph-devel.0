From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Severe performance degradation with jewel rbd image
Date: Thu, 26 May 2016 14:52:26 -0400
Message-ID: <CA+aFP1CqwRC8-EqPb0vTktQG0XViS8NO5TUg6BG9z0ooDPgbbw@mail.gmail.com>
References: <BL2PR02MB2115AA33422B53D2C0B65E7AF4400@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1B_+TqDLNzxpvNYCz_3-Wsc4HAHUtKLzoJ+xUvqNHE0NQ@mail.gmail.com>
	<BL2PR02MB21158B4F676CFDF982E52704F4400@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DsqsTxgy4cXqJSRADqOYa2QsA8UUVTNUuA2__GHm0BFw@mail.gmail.com>
	<BL2PR02MB21154CCDABC8037F9D63DA7AF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DapnzYpBDowdTjMVfrUcBSQy0tvYOEDM7QJJSy-kmPuw@mail.gmail.com>
	<BL2PR02MB2115791B5D2A2D163F7A2AEFF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DdPYWhRCeJ2buc7Gsz+gmti2BA4=7qoQHWP_Zi1_KyNQ@mail.gmail.com>
	<BL2PR02MB2115D73ED758ADC9C52729A6F4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CAN=+7FVX5WecZZ=2dj1vSeFC=WCBvJkO5Esi+UuTT+_2=aiX9A@mail.gmail.com>
	<CA+aFP1BH-sJE1e8BsTwS3s9D-246dYQoBrhTtAtauJFRi+G5jw@mail.gmail.com>
	<BL2PR02MB2115FA285EA269AB9D536FF0F4410@BL2PR02MB2115.namprd02.prod.outlook.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36101 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbcEZSw1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 14:52:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id f144so20323533pfa.3
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 11:52:26 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115FA285EA269AB9D536FF0F4410@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You can dynamically enable/disable exclusive-lock, object-map,
fast-diff, and journaling after the image is created via  "rbd feature
disable <image-spec> <feature>".  The deep-flatten feature can be
disabled-only via the same CLI.
