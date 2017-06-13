From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Are we ready for 10.2.8 - core
Date: Tue, 13 Jun 2017 11:20:58 -0400
Message-ID: <e2a46e29-a874-6a7d-40f1-5836da7a15db@redhat.com>
References: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753175AbdFMPVB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Jun 2017 11:21:01 -0400
In-Reply-To: <9e7edca0-d56a-2315-9098-94dab50db691@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/09/2017 12:09 PM, Nathan Cutler wrote:
> Hi Josh:
> 
> The following core backports have been merged into the jewel branch in 
> preparation for the 10.2.8 release.
> 
> http://tracker.ceph.com/projects/ceph/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=537&f%5B%5D=subproject_id&op%5Bsubproject_id%5D=%21*&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D= 
> 
> 
> Do you think it's time for QE to do its testing?

Could we also include:

https://github.com/ceph/ceph/pull/14392
https://github.com/ceph/ceph/pull/15529
