From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Building Ceph in Docker
Date: Tue, 29 Aug 2017 12:27:38 +0200
Message-ID: <a27efb29-bfc3-305a-5517-eb9b58612484@suse.cz>
References: <CAM+oqtHyc-1RSB1StOt2fUpJCS8b-5gwEHfLP9eDhgC2uq-mNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57381 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751238AbdH2K1k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Aug 2017 06:27:40 -0400
In-Reply-To: <CAM+oqtHyc-1RSB1StOt2fUpJCS8b-5gwEHfLP9eDhgC2uq-mNw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mingliang LIU <mingliang.liu@salesforce.com>, ceph-devel@vger.kernel.org

> I know we're building Ceph in Linux distributions and many of you use
> vstart.sh as I do. Steps to install dependencies are easy so we don't
> have to worry about prerequisites in a dev machine.
> 
> I'm thinking if it's useful to build Ceph in Docker. There are reasons
> to do this, for example 1) not be able/willing to install quite a few
> dependency software/library on a shared Linux, 2) to have a standard
> build image for isolated and automatic testing, and 3) to build on
> Mac/Windows. I know for this we can create Linux virtual machines on
> Mac/ Windows, but I think container is lightweight and better.
> 
> So I attach a small script that creates a Docker image to build the
> Ceph from source, and then starts a test cluster with vstart.sh in a
> container. Do you think it's something useful and/or worth to have in
> source tree?
> 
> When I was building Hadoop, I found its start-build-env.sh helpful,
> which is basically the same idea I borrowed here.

Have you looked at docker-test.sh ?

https://github.com/ceph/ceph/blob/master/src/test/docker-test.sh

I have not tried it in awhile, but it used to be able to not only build 
Ceph but also run "make check", in a Docker container. It support(ed) 
several different operating systems.

It would be nice if someone got it working again.

Nathan
