From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Compile error in Jenkins in rgw/rgw_data_sync.cc
Date: Tue, 10 May 2016 16:23:27 -0700
Message-ID: <CADRKj5SwFig45NZy7RSuDSKWCFvXT+rYn07ryKzEL9dc_ag5Nw@mail.gmail.com>
References: <3ab4655e-235d-1d8c-6072-cc796cb51746@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36467 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbcEJXX2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 19:23:28 -0400
Received: by mail-vk0-f46.google.com with SMTP id s184so36257768vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 16:23:28 -0700 (PDT)
In-Reply-To: <3ab4655e-235d-1d8c-6072-cc796cb51746@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Fixed, reverted offending commit.

Thanks,
Yehuda

On Tue, May 10, 2016 at 3:24 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
>   CXX      rgw/librgw_la-rgw_replica_log.lo
> rgw/rgw_data_sync.cc: In member function 'void
> RGWDataSyncStatusManager::finalize()':
> rgw/rgw_data_sync.cc:1383:3: error: 'sync_env' was not declared in this
> scope
>    sync_env = RGWDataSyncEnv{};
>    ^
>
> But I'm not sure which sync_env in what class needs exposure.
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
