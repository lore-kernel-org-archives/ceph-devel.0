From: Kyle Bader <kyle@inktank.com>
Subject: Re: Pyramid erasure codes and replica hinted recovery
Date: Sun, 12 Jan 2014 18:35:25 -0800
Message-ID: <CAHxYaFOzaeeRPv+N0mU_uWODUOvQnAe2kAn8rkuuSchFigkBAQ@mail.gmail.com>
References: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>
	<52D1F060.8050108@dachary.org>
	<CAHxYaFOg6N2ZP1=OuOWajXUqMFtGsq0u94DG=Ub8NcAaqFtj+g@mail.gmail.com>
	<52D2EEF8.8020009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:45155 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaAMCf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jan 2014 21:35:26 -0500
Received: by mail-ob0-f170.google.com with SMTP id uy5so5163972obc.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jan 2014 18:35:26 -0800 (PST)
In-Reply-To: <52D2EEF8.8020009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

> How is it different from what is described above? There must be something I fail to understand.

No misunderstanding on your part, on second look that does achieve the
desired placement. Could you please help walk me through the following
scenarios:

Can data or local parity chunks that have been lost (erasures) be
recovered locally, with no inter-dc backfill traffic?

Global parity chunks that are lost require reading....6x data or
global parity chunks (effectively 1x the original write)?

Would placement groups containing a data or local parity chunk that
have been remapped backfill from the local chunk (member of previous
acting set)?

Thanks!

-- 
Kyle Bader - Inktank
Senior Solution Architect
