% Enron Forensic Analysis - MATLAB Visualisations

%% 1. Anomaly Score Distribution
data = readtable('../results/anomaly_scores.csv');

figure('Position', [100 100 1000 600]);
subplot(1,2,1);
histogram(data.anomaly_score, 50, 'FaceColor', [0.42 0.55 1]);
xlabel('Isolation Forest Anomaly Score');
ylabel('Count');
title('Distribution of Anomaly Scores');

subplot(1,2,2);
scatter(data.avg_word_length, data.vocab_richness, 10, data.anomaly_score, 'filled');
colorbar;
xlabel('Avg Word Length');
ylabel('Vocabulary Richness');
title('Anomaly Scores by Stylistic Features');
colormap('cool');

saveas(gcf, '../results/graphs/matlab_anomaly_dist.png');

%% 2. Network Metrics
metrics = readtable('../results/network_metrics.csv');

figure('Position', [100 100 1000 500]);
subplot(1,2,1);
histogram(metrics.degree_centrality, 50, 'FaceColor', [1 0.42 0.61]);
xlabel('Degree Centrality');
ylabel('Count');
title('Network Degree Centrality Distribution');
set(gca, 'YScale', 'log');

subplot(1,2,2);
scatter(metrics.in_degree, metrics.out_degree, 10, [0.31 0.80 0.77], 'filled');
xlabel('In-Degree Centrality');
ylabel('Out-Degree Centrality');
title('In vs Out Degree Centrality');

saveas(gcf, '../results/graphs/matlab_network_metrics.png');

%% 3. Top Users Anomaly Comparison
[unique_users, ~, idx] = unique(data.user);
anomaly_counts = accumarray(idx, data.anomaly_iso == -1);
total_counts = accumarray(idx, 1);
anomaly_rate = anomaly_counts ./ total_counts;

[sorted_rate, sort_idx] = sort(anomaly_rate, 'descend');
top_n = 15;

figure('Position', [100 100 900 600]);
barh(1:top_n, sorted_rate(1:top_n), 'FaceColor', [0.42 0.55 1]);
set(gca, 'YTick', 1:top_n, 'YTickLabel', unique_users(sort_idx(1:top_n)));
xlabel('Anomaly Rate');
title('Top 15 Users by Anomaly Rate');
set(gca, 'YDir', 'reverse');

saveas(gcf, '../results/graphs/matlab_user_anomaly_rates.png');

fprintf('All MATLAB graphs saved to results/graphs/\n');