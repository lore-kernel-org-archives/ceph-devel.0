From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v6 8/9] ceph: add reset metrics support
Date: Mon, 10 Feb 2020 16:22:52 +0100
Message-ID: <CAOi1vP-c1HfKUNHz2MKdN=xrduEg+EfLZ_S_G9kthjJsL9z5=w@mail.gmail.com>
References: <20200210053407.37237-1-xiubli@redhat.com> <20200210053407.37237-9-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-il1-f195.google.com ([209.85.166.195]:44160 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBJPWf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Feb 2020 10:22:35 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so501357ill.11
        for <ceph-devel@vger.kernel.org>; Mon, 10 Feb 2020 07:22:34 -0800 (PST)
In-Reply-To: <20200210053407.37237-9-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 10, 2020 at 6:34 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Sometimes we need to discard the old perf metrics and start to get
> new ones. And this will reset the most metric counters, except the
> total numbers for caps and dentries.
>
> URL: https://tracker.ceph.com/issues/43215
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/debugfs.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 60f3e307fca1..6e595a37af5d 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -179,6 +179,43 @@ static int metric_show(struct seq_file *s, void *p)
>         return 0;
>  }
>
> +static ssize_t metric_store(struct file *file, const char __user *user_buf,
> +                           size_t count, loff_t *ppos)
> +{
> +       struct seq_file *s = file->private_data;
> +       struct ceph_fs_client *fsc = s->private;
> +       struct ceph_mds_client *mdsc = fsc->mdsc;
> +       struct ceph_client_metric *metric = &mdsc->metric;
> +       char buf[8];
> +
> +       if (copy_from_user(buf, user_buf, 8))
> +               return -EFAULT;
> +
> +       if (strncmp(buf, "reset", strlen("reset"))) {
> +               pr_err("Invalid set value '%s', only 'reset' is valid\n", buf);
> +               return -EINVAL;
> +       }

Hi Xiubo,

Why strncmp?  How does this handle inputs like "resetfoobar"?

> +
> +       percpu_counter_set(&metric->d_lease_hit, 0);
> +       percpu_counter_set(&metric->d_lease_mis, 0);
> +
> +       percpu_counter_set(&metric->i_caps_hit, 0);
> +       percpu_counter_set(&metric->i_caps_mis, 0);
> +
> +       percpu_counter_set(&metric->read_latency_sum, 0);
> +       percpu_counter_set(&metric->total_reads, 0);
> +
> +       percpu_counter_set(&metric->write_latency_sum, 0);
> +       percpu_counter_set(&metric->total_writes, 0);
> +
> +       percpu_counter_set(&metric->metadata_latency_sum, 0);
> +       percpu_counter_set(&metric->total_metadatas, 0);
> +
> +       return count;
> +}
> +
> +CEPH_DEFINE_RW_FUNC(metric);

More broadly, how are these metrics going to be used?  I suspect
the MDSes will gradually start relying on the them in the future
and probably make decisions based off of them?  If that is the case,
did you think about clients being able to mess with that by zeroing
these counters on a regular basis?

It looks like all of this is still in flight on the userspace side, but
I don't see anything similar in https://github.com/ceph/ceph/pull/32120.
Is there a different PR or is this kernel-only for some reason?

Thanks,

                Ilya
