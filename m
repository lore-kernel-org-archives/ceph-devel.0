From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw: "MethodNotAllowed" response for AWS C# Sample
Date: Wed, 23 Jan 2013 16:51:31 -0800
Message-ID: <CAC-hyiF5j_V4_Oou_6JSkDTBJzWLxWb+W=w_7YWhrEuv5WO8BQ@mail.gmail.com>
References: <CAJVE5RWMk8sbeLt52OuV+18aZeDa4J5x48x1bLyjSqT8RE4apw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50611 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3AXAvc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 19:51:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so8988755iea.33
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 16:51:31 -0800 (PST)
In-Reply-To: <CAJVE5RWMk8sbeLt52OuV+18aZeDa4J5x48x1bLyjSqT8RE4apw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 23, 2013 at 4:46 PM, Cesar Mello <cmello@gmail.com> wrote:
> Hi,
>
> When running the PutObject sample from
> http://ceph.com/docs/master/radosgw/s3/csharp/ I get a
> "MethodNotAllowed" response. Please has anyone successfully run this
> sample?
>
> I have tested with a current local build (0.56).
>

Is there anything in the radosgw log? in the apache access, error
logs? It might be that your apache has some other (maybe default) site
configured to handle requests, and it doesn't really reach radosgw.

Yehuda
