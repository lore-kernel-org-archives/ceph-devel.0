From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RFC: new rados whereis command
Date: Fri, 26 Dec 2014 09:54:10 +0200
Message-ID: <20141226075409.GA22340@gmail.com>
References: <5499EB3C.2040602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48285 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaLZHyU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Dec 2014 02:54:20 -0500
Received: by mail-lb0-f177.google.com with SMTP id b6so8085932lbj.22
        for <ceph-devel@vger.kernel.org>; Thu, 25 Dec 2014 23:54:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5499EB3C.2040602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 23, 2014 at 11:22:52PM +0100, Loic Dachary wrote:
> Hi Andreas,
> 
> I took a closer look at https://github.com/ceph/ceph/pull/2730
> implementing rados whereis [--dns] and I think it deserves a
> discussion here. If I understand correctly, it relies on a new
> function of the rados API:
> 
>   typedef struct whereis {
>     int64_t osd_id;                              //< ID of the OSD hosting this object
>     std::string osd_state;                       //< state of the OSD - either 'active' or 'inactive'

Wouldn't it be better to use enum instead of string for state?

>     int64_t pg_seed;                             //< Seed of the PG hosting this object
>     std::string ip_string;                       //< Ip as string
>     std::vector<std::string> host_names;         //< optional reverse DNS HostNames
>     std::map<std::string, std::string> user_map; //< optional user KV map
>     void resolve();                              //< reverse DNS OSD IPs and store in HostNames
>   } whereis_t;
> 
>   static int whereis(IoCtx &ioctx, const std::string &oid, std::vector<whereis_t> &locations);

-- 
Mykola Golub
