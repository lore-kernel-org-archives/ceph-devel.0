From: Tim Serong <tserong@suse.com>
Subject: Re: dashboard in mimic
Date: Thu, 21 Dec 2017 12:48:05 +1100
Message-ID: <5f5133a0-6a17-7404-c6fe-e1919c72594b@suse.com>
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0EF8B3D82857FDCE1D5C6C1E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52767 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756192AbdLUBsX (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 20 Dec 2017 20:48:23 -0500
In-Reply-To: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------0EF8B3D82857FDCE1D5C6C1E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

(broad topic :-), trimming back to my immediate comment/question)

On 12/20/2017 09:55 PM, John Spray wrote:
> What?
> =====
> 
> Extend the dashboard module to provide management of the cluster, in
> addition to monitoring.  This would potentially include anything you
> can currently do with the Ceph CLI, plus additional functionality like
> calling out to a container framework to spawn additional daemons.
> 
> The idea is to wrap things up into friendlier higher-level operations,
> rather than just having buttons for the existing CLI operations.
> Example workflows of interest:
>  - a CephFS page where you can click "New Filesystem", and the pools
> and MDS daemons will all be created for you.
>  - similarly for RGW: ability to enable RGW and control the number of
> gateway daemons
>  - driving OSD additional/retirement, and also format conversions
> (e.g. filestore->bluestore)
> 
> Some of the functionality would depend on how Ceph is being run:
> especially, anything that detects devices and starts/stops physical
> services would depend on an environment that provides that (such as
> Kubenetes).

Any configuration/management of things that ceph already knows about is
"easy" to implement (creating pools, rbd volumes, cluster config, etc.)

For spawning/configuring additional daemons, is it worth considering
some kind of thin layer (another mgr module or modules?) that let the
admin choose whether this is done by k8s, salt, ansible, whatever?

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com

--------------0EF8B3D82857FDCE1D5C6C1E
Content-Type: text/x-vcard;
 name="tserong.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="tserong.vcf"

bnVsbA==
--------------0EF8B3D82857FDCE1D5C6C1E--
