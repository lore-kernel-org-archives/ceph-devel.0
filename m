From: David Zafman <dzafman@redhat.com>
Subject: Re: LTTNG
Date: Tue, 03 Feb 2015 13:44:03 -0800
Message-ID: <54D14123.9060305@redhat.com>
References: <54D12349.7080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131AbbBCVoE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Feb 2015 16:44:04 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t13Li3Mr001735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 3 Feb 2015 16:44:04 -0500
Received: from Davids-iMac.local (vpn-228-207.phx2.redhat.com [10.3.228.207])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t13Li3vI023085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 3 Feb 2015 16:44:03 -0500
In-Reply-To: <54D12349.7080701@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


I did the following to get the latest stable release of LTTNG because 
the default Ubuntu packages weren't new enough.

Now do_autogen.sh works for me per Sage's change to make --with-lttng 
the default for developers.

sudo apt-add-repository ppa:lttng/ppa
sudo apt-get update
sudo apt-get install lttng-tools
sudo apt-get install liblttng-ust-dev

I skipped the following because I assume it is for kernel modules.
sudo apt-get install lttng-modules-dkms

David

On 2/3/15 11:36 AM, David Zafman wrote:
>
> On Ubuntu 12.04.1 LTS after doing an install-deps.sh and the new 
> do_autogen.sh without -L, I get a config error with this in the 
> config.log:
>
> configure:22637: checking if lttng-gen-tp is sane
> configure:22647: result: no
> configure:22681: checking lttng/tracepoint.h usability
> configure:22681: gcc -c  -g -Wextra -Wno-missing-field-initializers 
> -Wno-missing-declarations -Wno-unused-parameter  conftest.c >&5
> configure:22681: $? = 0
> configure:22681: result: yes
> configure:22681: checking lttng/tracepoint.h presence
> configure:22681: gcc -E  conftest.c
> configure:22681: $? = 0
> configure:22681: result: yes
> configure:22681: checking for lttng/tracepoint.h
> configure:22681: result: yes
> configure:22692: checking for lttng-gen-tp
> configure:22708: found /usr/bin/lttng-gen-tp
> configure:22719: result: yes
> configure:22737: error: in `/home/dzafman/ceph2':
> configure:22739: error: lttng-gen-tp does not behave properly
>
> David Zafman
> Senior Developer
> http://www.redhat.com
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

