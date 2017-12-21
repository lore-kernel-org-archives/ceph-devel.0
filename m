From: John Spray <jspray@redhat.com>
Subject: Re: dashboard in mimic
Date: Thu, 21 Dec 2017 10:42:48 +0000
Message-ID: <CALe9h7eoH+hRfV22BwZ4KWyMyWq8urNvsAC7+VByRKRSW00OMw@mail.gmail.com>
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
 <5f5133a0-6a17-7404-c6fe-e1919c72594b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45477 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbdLUKnK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Dec 2017 05:43:10 -0500
Received: by mail-wr0-f182.google.com with SMTP id h1so24740253wre.12
        for <ceph-devel@vger.kernel.org>; Thu, 21 Dec 2017 02:43:09 -0800 (PST)
In-Reply-To: <5f5133a0-6a17-7404-c6fe-e1919c72594b@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 21, 2017 at 1:48 AM, Tim Serong <tserong@suse.com> wrote:
> (broad topic :-), trimming back to my immediate comment/question)
>
> On 12/20/2017 09:55 PM, John Spray wrote:
>> What?
>> =====
>>
>> Extend the dashboard module to provide management of the cluster, in
>> addition to monitoring.  This would potentially include anything you
>> can currently do with the Ceph CLI, plus additional functionality like
>> calling out to a container framework to spawn additional daemons.
>>
>> The idea is to wrap things up into friendlier higher-level operations,
>> rather than just having buttons for the existing CLI operations.
>> Example workflows of interest:
>>  - a CephFS page where you can click "New Filesystem", and the pools
>> and MDS daemons will all be created for you.
>>  - similarly for RGW: ability to enable RGW and control the number of
>> gateway daemons
>>  - driving OSD additional/retirement, and also format conversions
>> (e.g. filestore->bluestore)
>>
>> Some of the functionality would depend on how Ceph is being run:
>> especially, anything that detects devices and starts/stops physical
>> services would depend on an environment that provides that (such as
>> Kubenetes).
>
> Any configuration/management of things that ceph already knows about is
> "easy" to implement (creating pools, rbd volumes, cluster config, etc.)
>
> For spawning/configuring additional daemons, is it worth considering
> some kind of thin layer (another mgr module or modules?) that let the
> admin choose whether this is done by k8s, salt, ansible, whatever?

Yes, absolutely -- the main two that have been discussed so far are
kubernetes and a notional baremetal fallback, where the bare metal
version would be something that has a very small set of commands
(discover devices, format an OSD, control a service with systemd) run
over SSH.

It's easy to imagine salt being another route to managing bare metal,
and probably working a bit more robustly than the super-simple pure
SSH bare metal option.  That said, we should think carefully about in
which sorts of scenarios an external orchestration tool needs to be in
the loop: for example I don't think we'd want to be calling into
salt/ansible in cases where they were just forwarding ops into
Kubernetes for us -- the core value of the external orchestrator is in
doing things we can't do ourselves, like working out the OS and
networking configuration, bootstrapping the container environment.

John
